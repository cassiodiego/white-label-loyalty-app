//
//  File.swift
//  
//
//  Created by Cassio Diego T. Campos on 05/08/20.
//

import Vapor
import FluentMySQL

final class Company: Codable {
  
  static let entity = "companies"
  
  var id: Int?
  var name: String
  var description: String
  var register: String
  
  init(name: String, description: String, register: String) {
    self.name = name
    self.description = description
    self.register = register
  }
}
  
extension Company: MySQLModel {}

extension Company: Migration {
    static func prepare(on connection: MySQLConnection) -> Future<Void> {
      return Database.create(self, on: connection) { builder in
        builder.field(for: \.id, isOptional: false, isIdentifier: true)
      }
    }
}

extension Company: Content {}

extension Company: Parameter {}

extension Company {
    var benefits: Siblings<Company, Benefit, BenefitCompanyPivot> {
      return siblings()
    }
}


