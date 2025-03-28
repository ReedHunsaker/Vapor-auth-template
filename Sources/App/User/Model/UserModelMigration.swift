//
//  UserModelMigration.swift
//  vapor-auth-template
//
//  Created by Reed hunsaker on 3/1/25.
//

import Vapor
import Fluent

struct UserMigration: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(UserModel.schema)
            .id()
            .field("email", .string, .required)
            .field("password_hash", .string, .required)
            .field("created_at", .datetime)
            .field("last_edited_at", .datetime)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(UserModel.schema).delete()
    }
}
