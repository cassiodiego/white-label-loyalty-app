//
//  routes.swift
//  white-label-loyalty-app
//
//  Created by Cassio Diego Tavares Campos on 05/08/20.
//  Copyright (c) 2020 Cassio Diego Tavares Campos. All rights reserved.
//

import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    let usersController = UsersController()
    try router.register(collection: usersController)

}
