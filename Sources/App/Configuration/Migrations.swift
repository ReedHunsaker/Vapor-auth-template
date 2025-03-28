//
//  Migrations.swift
//  vapor-auth-template
//
//  Created by Reed hunsaker on 3/8/25.
//

import Vapor
import Fluent

enum Migrations {
    static func addAll(_ app: Application) {
        app.migrations.add(UserMigration())
    }
}
