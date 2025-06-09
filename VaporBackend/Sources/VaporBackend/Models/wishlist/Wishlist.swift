//
//  Wishlist.swift
//  VaporBackend
//
//  Created by ROBIN HUMNE on 09/06/25.
//
import Vapor
import MongoKitten

struct WishlistResponse: Content {
    let items: [Product]
}
