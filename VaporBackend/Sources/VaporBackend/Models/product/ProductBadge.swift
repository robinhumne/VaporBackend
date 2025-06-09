//
//  ProductBadge.swift
//  VaporBackend
//
//  Created by ROBIN HUMNE on 09/06/25.
//
import Vapor
import MongoKitten

struct ProductBadge: Content, Equatable {
    let text: String
}
