//
//  AuthenticationController.swift
//  vapor-auth-template
//
//  Created by Reed hunsaker on 3/1/25.
//

import Vapor

func authenticationController(_ app: Application) throws -> RoutesBuilder {
    
    app.post("user", "create") { req async throws -> HTTPStatus in
        try User.Create.validate(content: req)
        let createUserData = try req.content.decode(User.Create.self)
        guard createUserData.password == createUserData.confirmPassword else {
            throw Abort(.badRequest, reason: "Passwords did not match")
        }
        let user = try UserModel(
            email: createUserData.email,
            passwordHash: Bcrypt.hash(createUserData.password)
        )
        try await user.save(on: req.db)
        return .accepted
    }
    
    let passwordProtected = app.grouped(UserModel.authenticator(), UserModel.guardMiddleware())
    
    passwordProtected.post("login") { req async throws -> User.LoginResponse in
        let user = try req.auth.require(UserModel.self)
        let payload = try UserSessionToken(user: user)
        let token = await ClientTokenResponse(token: try req.jwt.sign(payload))
        return User.LoginResponse(
            user: user.asUser(),
            session: token
        )
    }
    
    let secure = app.grouped(UserSessionToken.authenticator(), UserSessionToken.guardMiddleware())
    
    secure.get("user") { req async throws -> User in
        let sessionToken = try req.auth.require(UserSessionToken.self)
        print(sessionToken.userId)
        guard let userResponse = try await UserModel.find(sessionToken.userId, on: req.db).get() else { throw Abort(.notFound, reason: "No validated user found") }
        return userResponse.asUser()
    }
    
    return secure
}
