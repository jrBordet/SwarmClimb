import Routing
import Vapor
import Fluent

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {
    router.get("hello") { req -> Future<View> in
        return try req.view().render("hello", ["name": "hello"])
    }
    
    let usersController = UsersController()
    try router.register(collection: usersController)
    
    let websiteController = WebsiteController()
    try router.register(collection: websiteController)

}

