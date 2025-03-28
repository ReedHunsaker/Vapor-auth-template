//
//  UserController.swift
//  vapor-auth-template
//
//  Created by Reed hunsaker on 3/1/25.
//

import Foundation
import Vapor

func userController(_ app: Application, secureRoutes secure: RoutesBuilder) throws {
    
    secure.get("user", "all") { req async throws -> [User] in
        let user = try await req.user()
        guard let userId = user.id else { return [User]() }
        
        let userModels = try await UserModel.query(on: req.db)
            .filter(\.$id, .equality(inverse: true), userId)
            .all()
        
        let users: [User] = userModels
            .sorted {
                $0.createdAt ?? Date() > $1.createdAt ?? Date()
            }
            .map { $0.asUser() }
        
        return users
    }
}
