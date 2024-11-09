import Foundation
import Fluent
import Vapor

class UserController: RouteCollection, @unchecked Sendable {
    
    // /api/register
    // /api/login
    
    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("api")
        
        // /api/register
        api.post("register", use: register)
    }
    
    @Sendable
    func register(req: Request) async throws -> RegisterResponseDTO {
        
        // validate the user // validations
        try User.validate(content: req)
        
        let user = try req.content.decode(User.self)
        
        // find if the user already exists using the username
        if let _ = try await User.query(on: req.db)
            .filter(\.$username == user.username)
            .first() {
            throw Abort(.conflict, reason: "Username is already taken.")
        }
        
        // hash the password
        user.password = try await req.password.async.hash(user.password)
        // save the user to database
        try await user.save(on: req.db)
        
        return RegisterResponseDTO(error: false)
    }
    
    @Sendable
    func login(req: Request) async throws -> String {
        
        // decode the request
        let user = try req.content.decode(User.self)
        
        // check if the user is in the database
        guard let existingUser = try await User.query(on: req.db)
            .filter(\.$username == user.username)
            .first() else {
                throw Abort(.badRequest)
            }
        
        // validate the password
        let result = try await req.password.async.verify(user.password, created: existingUser.password)
        
        if !result {
            throw Abort(.unauthorized)
        }
        
        // generate the token and return it to the user
        
        
        return "OK"
    }
}
