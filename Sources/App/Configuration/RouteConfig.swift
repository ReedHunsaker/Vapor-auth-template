//
//  RouteConfig.swift
//  vapor-auth-template
//
//  Created by Reed hunsaker on 3/8/25.
//

import Vapor

enum RouteConfig {
    static func setup(_ app: Application) throws {
        try publicRoutes(app)
        let secure = try authenticationController(app)
        try userController(app, secureRoutes: secure)
    }
}
