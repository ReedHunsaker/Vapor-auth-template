//
//  Request+UserModel.swift
//  vapor-auth-template
//
//  Created by Reed hunsaker on 3/1/25.
//

import Fluent
import Vapor

extension Request {
    func user() async throws -> UserModel {
        let session = try self.auth.require(UserSessionToken.self)
        guard let user = try await UserModel.find(session.userId, on: self.db) else {
            throw UserAuthenticationErrors.SessionTokenNotFound
        }
        return user
    }
}
