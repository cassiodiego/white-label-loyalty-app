//
//  Company.swift
//  white-label-loyalty-app
//
//  Created by Cassio Diego Tavares Campos on 08/08/20.
//  Copyright (c) 2020 Cassio Diego Tavares Campos. All rights reserved.
//

import Foundation
import Vapor
import FluentMySQL

final class Company: Codable {
    
    static let entity = "companies"
    
    var id: Int?
    var name: String
    var cnpj: String
    var description: String
    
    init(name: String,
         cnpj: String,
         description: String {
        self.name = name
        self.cnpj = cnpj
        self.description = description
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


