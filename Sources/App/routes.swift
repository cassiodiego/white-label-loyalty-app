//
//  routes.swift
//  white-label-loyalty-app
//
//  Created by Cassio Diego Tavares Campos on 05/08/20.
//  Copyright (c) 2020 Cassio Diego Tavares Campos. All rights reserved.
//

import Vapor

/// Register of application's routes.
public func routes(_ router: Router) throws {
    
    let benefitsController = BenefitsController()
    try router.register(collection: benefitsController)
    
    let usersController = UsersController()
    try router.register(collection: usersController)
    
    let companiesController = CompaniesController()
    try router.register(collection: companiesController)
    
}
