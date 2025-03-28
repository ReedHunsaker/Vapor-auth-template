//
//  DatabaseConfig.swift
//  vapor-auth-template
//
//  Created by Reed hunsaker on 3/8/25.
//

import Vapor
import Fluent
import FluentPostgresDriver

enum DatabaseConfig {
    static func configurePostgres(_ app: Application) {
        let postgresConfig = SQLPostgresConfiguration(
            hostname: Environment.get("POSTGRES_HOSTNAME") ?? "localhost",
            port: Environment.get("POSTGRES_PORT").flatMap(Int.init(_:))
              ?? SQLPostgresConfiguration.ianaPortNumber,
            username: Environment.get("POSTGRES_USERNAME") ?? "vapor_username",
            password: Environment.get("POSTGRES_PASSWORD") ?? "vapor_password",
            database: Environment.get("POSTGRES_DATABASE") ?? "vapor_database",
            tls: .disable
        )
        
        app.databases.use(.postgres(configuration: postgresConfig), as: .psql)
    }
}
