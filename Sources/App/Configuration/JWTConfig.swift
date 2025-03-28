//
//  JWTConfig.swift
//  vapor-auth-template
//
//  Created by Reed hunsaker on 3/8/25.
//

import JWT
import Vapor

enum JWTConfig {
    static func setup(_ app: Application) async throws {
        guard let jwtKey = Environment.get("JWT_KEY") else { throw JWTKeyError .keyNotFound }
        let hmacKey = HMACKey(from: jwtKey)
        await app.jwt.keys.add(hmac: hmacKey, digestAlgorithm: .sha256)
    }
    
    private enum JWTKeyError: Error {
        case keyNotFound
    }
}
