//
//  Company.swift
//  white-label-loyalty-app
//
//  Created by Cassio Diego Tavares Campos on 08/08/20.
//  Copyright (c) 2020 Cassio Diego Tavares Campos. All rights reserved.
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

extension Company: MySQLModel { }

extension Company: Migration {
    static func prepare(on connection: MySQLConnection) -> Future<Void> {
        return Database.create(self, on: connection) { builder in
            builder.field(for: \.id, isIdentifier: true)
        }
    }
}

extension Company: Content { }

extension Company: Parameter { }

extension Company {
    var benefits: Siblings<Company, Benefit, BenefitCompanyPivot> {
        return siblings()
    }
}


