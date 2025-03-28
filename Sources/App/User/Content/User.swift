//
//  User.swift
//  vapor-auth-template
//
//  Created by Reed hunsaker on 3/1/25.
//

import Vapor

/// Data shared with the client about the user
struct User: Content {
    let id: UUID?
    let email: String
}

extension User: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .email)
    }
}

extension UserModel {
    func asUser() -> User {
        User(id: id, email: email)
    }
}
