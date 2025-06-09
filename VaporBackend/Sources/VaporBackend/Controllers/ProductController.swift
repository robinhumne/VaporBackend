//
//  ProductController.swift
//  VaporBackend
//
//  Created by ROBIN HUMNE on 09/06/25.
//
import Vapor
import MongoKitten

struct ProductController {
    static let products: [Product] = [
        Product(
            id: Int32(904126),
            name: "Fairy sandals",
            originalPrice: "6,880 AED",
            salePrice: "6,467 AED",
            brandName: "René Caovilla",
            discountPercentage: "% 6",
            image: ProductImage(
                url: "https://www.levelshoes.com/media/catalog/product/cache/d6b308721eea44dce854000e2ac7b2ba/c/1/c12493-080-r0013407_1.jpg",
                height: 850,
                width: 607,
                gender: nil
            ),
            badges: [
                ProductBadge(text: "★"),
                ProductBadge(text: "NEW")
            ]
        ),
        Product(
            id: Int32(903636),
            name: "Wander matelassé small hobo bag",
            originalPrice: "10,500 AED",
            salePrice: "5,565 AED",
            brandName: "Miu Miu",
            discountPercentage: "% 47",
            image: ProductImage(
                url: "https://www.levelshoes.com/media/catalog/product/cache/d6b308721eea44dce854000e2ac7b2ba/5/b/5bc125ooyan88f0236v_1.jpg",
                height: 850,
                width: 607,
                gender: nil
            ),
            badges: [
                ProductBadge(text: "NEW")
            ]
        ),
        Product(
            id: Int32(907099),
            name: "Blondie medium top handle bag",
            originalPrice: "13,500 AED",
            salePrice: "9,585 AED",
            brandName: "Gucci",
            discountPercentage: "% 29",
            image: ProductImage(
                url: "https://www.levelshoes.com/media/catalog/product/cache/d6b308721eea44dce854000e2ac7b2ba/8/1/815714aaec24928_1.jpg",
                height: 850,
                width: 607,
                gender: nil
            ),
            badges: [
                ProductBadge(text: "NEW")
            ]
        ),
        Product(
            id: Int32(907060),
            name: "Ixia 80 pumps",
            originalPrice: "3,400 AED",
            salePrice: "2,108 AED",
            brandName: "Jimmy Choo",
            discountPercentage: "% 38",
            image: ProductImage(
                url: "https://www.levelshoes.com/media/catalog/product/cache/d6b308721eea44dce854000e2ac7b2ba/j/0/j000177767_1.jpg",
                height: 850,
                width: 607,
                gender: nil
            ),
            badges: [
                ProductBadge(text: "NEW")
            ]
        ),
        Product(
            id: Int32(902581),
            name: "VLogo Signature Cherryfic mini shoulder bag",
            originalPrice: "4,500 AED",
            salePrice: "2,250 AED",
            brandName: "Valentino Garavani",
            discountPercentage: "% 50",
            image: ProductImage(
                url: "https://www.levelshoes.com/media/catalog/product/cache/d6b308721eea44dce854000e2ac7b2ba/w/p/wp0ak8cjrr9f_1.jpg",
                height: 850,
                width: 607,
                gender: nil
            ),
            badges: [
                ProductBadge(text: "NEW")
            ]
        ),
        Product(
            id: Int32(902628),
            name: "Small Skull bag",
            originalPrice: "3,780 AED",
            salePrice: "3,666 AED",
            brandName: "McQueen",
            discountPercentage: "% 3",
            image: ProductImage(
                url: "https://www.levelshoes.com/media/catalog/product/cache/d6b308721eea44dce854000e2ac7b2ba/6/1/6130881hb0i4900_1.jpg",
                height: 850,
                width: 607,
                gender: nil
            ),
            badges: [
                ProductBadge(text: "NEW")
            ]
        ),
        Product(
            id: Int32(902628),
            name: "Horsebit espadrille mules",
            originalPrice: "3,400 AED",
            salePrice: "3,196 AED",
            brandName: "Gucci",
            discountPercentage: "% 6",
            image: ProductImage(
                url: "https://www.levelshoes.com/media/catalog/product/cache/d6b308721eea44dce854000e2ac7b2ba/8/3/832430c20004928_1.jpg",
                height: 850,
                width: 607,
                gender: nil
            ),
            badges: [
                ProductBadge(text: "PRE-LAUNCH"),
                ProductBadge(text: "NEW")
            ]
        )
        // Add more sample products as needed
    ]
    
    func list(req: Request) async throws -> ProductResponse {
        return ProductResponse(products: ProductController.products)
    }
    
    func fetchAll(req: Request) async throws -> ProductResponse {
        let collection = req.mongoDB["products"]
        
        // Create query (empty to fetch all)
        let query: Document = [:]
        
        // Get all products
        let products = try await collection.find(query)
            .decode(Product.self)
            .drain()
        req.logger.info("products data::: \(products)")
        return ProductResponse(products: products)
    }
}
