//
//  Token.swift
//  white-label-loyalty-app
//
//  Created by Cassio Diego Tavares Campos on 05/08/20.
//  Copyright (c) 2020 Cassio Diego Tavares Campos. All rights reserved.
//

import Vapor
import FluentMySQL
import Foundation
import Crypto
import Authentication

final class Token: Codable {
    
  static let entity = "tokens"

  var id: UUID?
  var token: String
  var users_id: User.ID
  
  init(token: String, users_id: User.ID) {
    self.token = token
    self.users_id = users_id
  }
}

extension Token: MySQLUUIDModel {}
extension Token: Content {}
extension Token: Migration {}

extension Token {
  var user: Parent<Token, User> {
    return parent(\.users_id)
  }
}

extension Token {
  static func generate(for user: User) throws -> Token {
    let random = try CryptoRandom().generateData(count: 16)
    return try Token(token: random.base64EncodedString(), users_id: user.requireID())
  }
}

extension Token: Authentication.Token {
  static let userIDKey: UserIDKey = \Token.users_id
  typealias UserType = User
}

extension Token: BearerAuthenticatable {
  static let tokenKey: TokenKey = \Token.token
}
