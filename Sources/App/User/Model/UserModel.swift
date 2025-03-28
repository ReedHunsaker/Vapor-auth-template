//
//  UserModel.swift
//  vapor-auth-template
//
//  Created by Reed hunsaker on 3/1/25.
//

import Vapor
import Fluent

final class UserModel: Model, Content, @unchecked Sendable {
    
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "password_hash")
    var passwordHash: String
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "last_edited_at", on: .update)
    var lastEditedAt: Date?
    
    init() { }

    init(
        id: UUID? = nil,
        email: String,
        passwordHash: String
    ) {
        self.id = id
        self.email = email
        self.passwordHash = passwordHash
    }
}
