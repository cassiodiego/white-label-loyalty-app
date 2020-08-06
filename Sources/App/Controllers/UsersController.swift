//
//  UsersController.swift
//  white-label-loyalty-app
//
//  Created by Cassio Diego Tavares Campos on 05/08/20.
//  Copyright (c) 2020 Cassio Diego Tavares Campos. All rights reserved.
//

import Vapor
import Crypto

struct UsersController: RouteCollection {
  func boot(router: Router) throws {
    let usersRoute = router.grouped("v1", "users")
    usersRoute.post(use: createHandler)
    usersRoute.get(use: getAllHandler)
    usersRoute.get(User.parameter, use: getHandler)
    
    let basicAuthMiddleware = User.basicAuthMiddleware(using: BCryptDigest())
    let basicAuthGroup = usersRoute.grouped(basicAuthMiddleware)
    basicAuthGroup.post("login", use: loginHandler)
  }
  
  func createHandler(_ req: Request) throws -> Future<User.Public> {
    return try req.content.decode(User.self).flatMap(to: User.Public.self) { user in
      user.password = try BCrypt.hash(user.password)
      return user.save(on: req).convertToPublic()
    }
  }
  
  func getAllHandler(_ req: Request) throws -> Future<[User.Public]> {
    return User.query(on: req).decode(data: User.Public.self).all()
  }
  
  func getHandler(_ req: Request) throws -> Future<User.Public> {
    return try req.parameters.next(User.self).convertToPublic()
  }
  
  func loginHandler(_ req: Request) throws -> Future<Token> {
    let user = try req.requireAuthenticated(User.self)
    let token = try Token.generate(for: user)
    return token.save(on: req)
  }
}
