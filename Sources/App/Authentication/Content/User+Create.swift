//
//  User+Create.swift
//  vapor-auth-template
//
//  Created by Reed hunsaker on 3/1/25.
//

import Vapor

extension User {
    struct Create: Content {
        var email: String
        var password: String
        var confirmPassword: String
    }
}

extension User.Create: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("email", as: String.self, is: .email)
        validations.add("password", as: String.self, is: .count(8...))
    }
}
