//
//  BenefitsController.swift
//  white-label-loyalty-app
//
//  Created by Cassio Diego Tavares Campos on 05/08/20.
//  Copyright (c) 2020 Cassio Diego Tavares Campos. All rights reserved.
//

import Vapor
import Fluent

struct BenefitsController: RouteCollection {
  func boot(router: Router) throws {
    let benefitsRoute = router.grouped("v1", "benefits")
    benefitsRoute.post(use: createHandler)
    benefitsRoute.get(use: getAllHandler)
    benefitsRoute.get(Benefit.parameter, use: getHandler)
    benefitsRoute.get(Benefit.parameter, "companies", use: getCompaniesHandler)
    benefitsRoute.get("search", use: searchHandler)
  }
  
  func createHandler(_ req: Request) throws -> Future<Benefit> {
    let benefit = try req.content.decode(Benefit.self)
    return benefit.save(on: req)
  }
  
  func getAllHandler(_ req: Request) throws -> Future<[Benefit]> {
    return Benefit.query(on: req).all()
  }
  
  func getHandler(_ req: Request) throws -> Future<Benefit> {
    return try req.parameters.next(Benefit.self)
  }
    
  func getCompaniesHandler(_ req: Request) throws -> Future<[Company]> {
    return try req.parameters.next(Benefit.self).flatMap(to: [Company].self) { benefit in
      return try benefit.companies.query(on: req).all()
    }
  }
    
  func searchHandler(_ req: Request) throws -> Future<[Benefit]> {
    guard let searchTerm = req.query[String.self, at: "term"] else {
      throw Abort(.badRequest)
    }
    return Benefit.query(on: req).group(.or) { or in
      or.filter(\.title == searchTerm)
      }.all()
  }
}

struct BenefitCreateData: Content {
  var title: String
  var description: String
  var points: Float
  var status: Int
  var amount: Int
  var expiration: String
  var companies_id: Int
}
