//
//  WishlistController.swift
//  VaporBackend
//
//  Created by ROBIN HUMNE on 09/06/25.
//
import Vapor
import MongoKitten

struct WishlistController {
    func getWishlist(req: Request) async throws -> WishlistResponse {
        guard let userId = req.parameters.get("userID") else {
            throw Abort(.badRequest, reason: "Missing userID")
        }

        let wishlistCollection = req.mongoDB["wishlistItems"]
        let query: Document = ["userId": userId]

        var items: [Product] = []
        let cursor = wishlistCollection.find(query)

        for try await doc in cursor {
            let item = try BSONDecoder().decode(Product.self, from: doc)
            items.append(item)
        }
        return WishlistResponse(items: items)
    }
    
    func addToWishlist(req: Request) async throws -> HTTPStatus {
        guard let userId = req.parameters.get("userID"),
              let productId = req.parameters.get("productID", as: Int32.self) else {
            throw Abort(.badRequest, reason: "Missing userID or productID")
        }

        let productsCollection = req.mongoDB["products"]
        let wishlistCollection = req.mongoDB["wishlistItems"]
    
        let productQuery: Document = ["id": Int32(productId)]
        guard let productDocument = try await productsCollection.findOne(productQuery) else {
            throw Abort(.notFound, reason: "Product not found")
        }
        
        let decoder = BSONDecoder()
        let product = try decoder.decode(Product.self, from: productDocument)
        
        let existingQuery: Document = [
            "userId": userId,
            "product.id": productId
        ]
        
        if try await wishlistCollection.findOne(existingQuery) != nil {
            throw Abort(.conflict, reason: "Product already in wishlist")
        }
        let wishlistItem = WishlistResponse(items: [product])
        
        let encoder = BSONEncoder()
        let document = try encoder.encode(wishlistItem)
        try await wishlistCollection.insertEncoded(document)
        return .created
    }

    func removeFromWishlist(req: Request) async throws -> HTTPStatus {
        guard let userId = req.parameters.get("userID"),
              let productId = req.parameters.get("productID", as: Int.self) else {
            throw Abort(.badRequest)
        }

        _ = try await req.mongoDB["wishlistItems"]
            .deleteOne(where: ["userId": userId, "productId": productId])

        return .noContent
    }
}
