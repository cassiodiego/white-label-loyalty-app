//
//  User.swift
//  white-label-loyalty-app
//
//  Created by Cassio Diego Tavares Campos on 05/08/20.
//  Copyright (c) 2020 Cassio Diego Tavares Campos. All rights reserved.
//

import Foundation
import Vapor
import FluentMySQL
import Authentication

final class User: Codable {
  
  static let entity = "users"
    
  var id: UUID?
  var name: String
  var email: String
  var password: String
  
  init(name: String, email: String, password: String) {
    self.name = name
    self.email = email
    self.password = password
  }
  
  final class Public: Codable {
    var id: UUID?
    var name: String
    var email: String
    
    init(id: UUID?, name: String, email: String) {
      self.id = id
      self.name = name
      self.email = email
    }
  }
}

extension User: MySQLUUIDModel {}
extension User: Migration {
  static func prepare(on connection: MySQLConnection) -> Future<Void> {
    return Database.create(self, on: connection) { builder in
      try addProperties(to: builder)
        builder.unique(on: \.email)
    }
  }
}

extension User: Content {}

extension User: Parameter {}

extension User { }

extension User.Public: Content {}

extension User {
  func convertToPublic() -> User.Public {
    return User.Public(id: id, name: name, email: email)
  }
}

extension Future where T: User {
  func convertToPublic() -> Future<User.Public> {
    return self.map(to: User.Public.self) { user in
      return user.convertToPublic()
    }
  }
}

extension User: BasicAuthenticatable {
  static let usernameKey: UsernameKey = \User.email
  static let passwordKey: PasswordKey = \User.password
}

extension User: TokenAuthenticatable {
  typealias TokenType = Token
}

extension User: PasswordAuthenticatable {}
extension User: SessionAuthenticatable {}
