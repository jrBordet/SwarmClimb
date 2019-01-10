import Vapor
import Leaf

struct WebsiteController: RouteCollection {
    func boot(router: Router) throws {
        router.get(use: indexHandler)
    }
    
    func indexHandler(_ req: Request) throws -> Future<View> {
        return
            User
                .query(on: req)
                .all()
                .flatMap(to: View.self, { users in
                    let usersData = users.isEmpty ? nil : users
                    
                    let context = IndexContent(title: "Climb challenge",
                                               users: usersData)
                    
                    return try req.view().render("index", context)
                })
        
    }
}

struct IndexContent: Encodable {
    let title: String
    let users: [User]?
}
