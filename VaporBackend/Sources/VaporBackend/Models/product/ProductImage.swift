//
//  ProductImage.swift
//  VaporBackend
//
//  Created by ROBIN HUMNE on 09/06/25.
//
import Vapor
import MongoKitten

struct ProductImage: Content, Equatable {
    let url: String
    let height: Int
    let width: Int
    let gender: String?
}
