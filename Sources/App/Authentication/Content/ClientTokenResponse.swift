//
//  ClientTokenResponse.swift
//  vapor-auth-template
//
//  Created by Reed hunsaker on 3/1/25.
//

import Vapor

struct ClientTokenResponse: Content {
    var token: String
}
