import Vapor
import MongoKitten

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // Configure MongoDB
//    app.mongoDB = try MongoDBStorage.create(for: app)
    
    app.logger.notice("Attempting MongoDB connection...")
    do {
        app.mongoDB = try MongoDBStorage.create(for: app)
        app.logger.notice("✅ MongoDB connection established")
    } catch {
        app.logger.critical("❌ MongoDB connection failed: \(error)")
        throw error
    }
    
    app.middleware.use(ErrorMiddleware.default(environment: app.environment))
    
    // register routes
    try routes(app)
}
