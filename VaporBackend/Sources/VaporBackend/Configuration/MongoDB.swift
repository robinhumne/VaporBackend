//
//  MongoDB.swift
//  VaporBackend
//
//  Created by ROBIN HUMNE on 09/06/25.
//
import Vapor
import MongoKitten

struct MongoDBStorage {
    let db: MongoDatabase
    
    static func create(for app: Application) throws -> MongoDBStorage {
//        let connectionString = "mongodb://root:example@localhost:27017/wishlist?authSource=admin"
//        let connectionString = "mongodb://root:example@localhost:27017/wishlist?authSource=admin&retryWrites=true&w=majority"
        let connectionString = "mongodb://wishlist_user:wishlist_password@localhost:27017/wishlist?authSource=wishlist"

        let db = try MongoDatabase.lazyConnect(to: connectionString)
        return MongoDBStorage(db: db)
    }
}

extension Application {
    var mongoDB: MongoDBStorage {
        get {
            guard let storage = storage[Key.self] else {
                fatalError("MongoDB not configured. Use app.mongoDB = ...")
            }
            return storage
        }
        set {
            storage[Key.self] = newValue
        }
    }
    
    private struct Key: StorageKey {
        typealias Value = MongoDBStorage
    }
}

// Add this extension for Request
extension Request {
    var mongoDB: MongoDatabase {
        return application.mongoDB.db
    }
}
