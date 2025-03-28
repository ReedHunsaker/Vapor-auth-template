//
//  withApp.swift
//  vapor-auth-template
//
//  Created by Reed hunsaker on 3/10/25.
//

import Vapor
@testable import App

enum TestingApp {
    
    /// Configures the application for testing on the database
    ///
    /// This function must be used in a serialized context to avoid reverting a database that is being tested.
    static func withDatabase(_ test: (Application) async throws -> ()) async throws {
        let app = try await Application.make(.testing)
        do {
            try await configure(app)
            try await app.autoMigrate()
            try await test(app)
            try await app.autoRevert()
        }
        catch {
            try? await app.autoRevert()
            try await app.asyncShutdown()
            throw error
        }
        try await app.asyncShutdown()
    }
}

