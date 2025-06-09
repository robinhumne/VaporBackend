import Vapor

func routes(_ app: Application) throws {
    let productController = ProductController()
    let wishlistController = WishlistController()
    
    // Product endpoints
    app.get("products", use: productController.list)
    
    // Product routes
//    app.get("products", use: productController.fetchAll)
    
    // Wishlist endpoints
    app.get("wishlist", ":userID", use: wishlistController.getWishlist)
    app.post("wishlist", ":userID", ":productID", use: wishlistController.addToWishlist)
    app.delete("wishlist", ":userID", ":productID", use: wishlistController.removeFromWishlist)
}
