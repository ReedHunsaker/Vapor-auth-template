//
//  UserModel+Authenticatable.swift
//  vapor-auth-template
//
//  Created by Reed hunsaker on 3/1/25.
//

import Fluent
import Vapor

extension UserModel: ModelAuthenticatable {
    static let usernameKey = \UserModel.$email
    static let passwordHashKey = \UserModel.$passwordHash

    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.passwordHash)
    }
}
