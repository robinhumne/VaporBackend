//
//  Product.swift
//  VaporBackend
//
//  Created by ROBIN HUMNE on 09/06/25.
//
import Vapor
import MongoKitten

struct Product: Content, Equatable {
    let id: Int32
    let name: String
    let originalPrice: String
    let salePrice: String
    let brandName: String
    let discountPercentage: String?
    let image: ProductImage
    let badges: [ProductBadge]?
}

struct ProductResponse: Content {
    let products: [Product]
}
// Add MongoKitten 8.0+ compatibility
extension Product {
    func makeDocument() -> Document {
        var document = Document()
        document["id"] = id
        document["name"] = name
        document["originalPrice"] = originalPrice
        document["salePrice"] = salePrice
        document["brandName"] = brandName
        document["discountPercentage"] = discountPercentage
        document["image"] = [
            "url": image.url,
            "height": image.height,
            "width": image.width,
            "gender": image.gender as Any
        ] as [String : Any] as? any Primitive
        document["badges"] =  badges?.map { ["text": $0.text].document }
        return document
    }
    
    init(document: Document) throws {
        id = document["id"].unsafelyUnwrapped as? Int32 ?? 0
        name = document["name"].unsafelyUnwrapped as? String ?? ""
        originalPrice = document["originalPrice"].unsafelyUnwrapped as? String ?? ""
        salePrice = document["salePrice"].unsafelyUnwrapped as? String ?? ""
        brandName = document["brandName"].unsafelyUnwrapped as? String ?? ""
        discountPercentage = document["discountPercentage"] as? String
        
        let imageDoc = document["image"].unsafelyUnwrapped as! Document
        image = ProductImage(
            url: imageDoc["url"].unsafelyUnwrapped as? String ?? "",
            height: Int(imageDoc["height"].unsafelyUnwrapped as? Int32 ?? 0),
            width: Int(imageDoc["width"].unsafelyUnwrapped as? Int32 ?? 0),
            gender: imageDoc["gender"] as? String
        )
        
        badges = (document["badges"] as? [Document])?.map {
            ProductBadge(text: $0["text"].unsafelyUnwrapped as? String ?? "")
        }
    }
}
