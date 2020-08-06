//
//  CompaniesController.swift
//  white-label-loyalty-app
//
//  Created by Cassio Diego Tavares Campos on 05/08/20.
//  Copyright (c) 2020 Cassio Diego Tavares Campos. All rights reserved.
//

import Vapor

struct CompaniesController: RouteCollection {
  func boot(router: Router) throws {
    let companiesRoute = router.grouped("v1", "companies")
    companiesRoute.post(use: createHandler)
    companiesRoute.get(use: getAllHandler)
    companiesRoute.get(Company.parameter, use: getHandler)
    companiesRoute.get(Company.parameter, "benefits", use: getBenefitsHandler)

  }
  
  func createHandler(_ req: Request) throws -> Future<Company> {
    let company = try req.content.decode(Company.self)
    return company.save(on: req)
  }
  
  func getAllHandler(_ req: Request) throws -> Future<[Company]> {
    return Company.query(on: req).all()
  }
  
  func getHandler(_ req: Request) throws -> Future<Company> {
    return try req.parameters.next(Company.self)
  }
  
  func getBenefitsHandler(_ req: Request) throws -> Future<[Benefit]> {
    return try req.parameters.next(Company.self).flatMap(to: [Benefit].self) { company in
      return try company.benefits.query(on: req).all()
    }
  }
}
