//
//  Benefit.swift
//  white-label-loyalty-app
//
//  Created by Cassio Diego Tavares Campos on 05/08/20.
//  Copyright (c) 2020 Cassio Diego Tavares Campos. All rights reserved.
//

import Foundation
import Vapor
import FluentMySQL

final class Benefit: Codable {
  
  static let entity = "benefits"

  var id: Int?
  var title: String
  var description: String
  var points: Float
  var status: Int
  var amount: Int
  var expiration: String
  var companies_id: Int
  
    init(title: String, description: String, points: Float, status: Int, amount: Int, expiration: String, companies_id: Int) {
    self.title = title
    self.description = description
    self.points = points
    self.status = status
    self.amount = amount
    self.expiration = expiration
    self.companies_id = companies_id
  }
}

extension Benefit: MySQLModel {}

extension Benefit: Migration {
    static func prepare(on connection: MySQLConnection) -> Future<Void> {
      return Database.create(self, on: connection) { builder in
        builder.field(for: \.id, isOptional: false, isIdentifier: true)
      }
    }
}

extension Benefit: Content {}

extension Benefit: Parameter {}

extension Benefit {
    var companies: Siblings<Benefit, Company, BenefitCompanyPivot> {
      return siblings()
    }
}

