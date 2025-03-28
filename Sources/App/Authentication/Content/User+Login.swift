//
//  User+Login.swift
//  vapor-auth-template
//
//  Created by Reed hunsaker on 3/1/25.
//

import Vapor

extension User {
    struct Login: Content, Validatable {
        var email: String
        var password: String

        static func validations(_ validations: inout Validations) {
            validations.add("email", as: String.self, is: .email)
            validations.add("password", as: String.self, is: .count(8...))
        }
    }
    
    struct LoginResponse: Content {
        var user: User
        var session: ClientTokenResponse?
    }
}
