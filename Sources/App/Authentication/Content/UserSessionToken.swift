//
//  UserSessionToken.swift
//  vapor-auth-template
//
//  Created by Reed hunsaker on 3/1/25.
//

import JWT
import Vapor

struct UserSessionToken: Content, Authenticatable, JWTPayload {

    static let expirationTime: TimeInterval = 60 * 15

    var expiration: ExpirationClaim
    var userId: UUID

    init(userId: UUID) {
        self.userId = userId
        self.expiration = ExpirationClaim(value: Date().addingTimeInterval(UserSessionToken.expirationTime))
    }

    init(user: UserModel) throws {
        self.userId = try user.requireID()
        self.expiration = ExpirationClaim(value: Date().addingTimeInterval(UserSessionToken.expirationTime))
    }

    func verify(using algorithm: some JWTAlgorithm) async throws {
        try expiration.verifyNotExpired()
    }
}
