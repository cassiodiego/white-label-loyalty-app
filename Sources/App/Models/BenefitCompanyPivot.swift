//
//  BenefitCompanyPivot.swift
//  white-label-loyalty-app
//
//  Created by Cassio Diego Tavares Campos on 05/08/20.
//  Copyright (c) 2020 Cassio Diego Tavares Campos. All rights reserved.
//

import FluentMySQL
import Vapor
import Foundation

final class BenefitCompanyPivot: MySQLUUIDPivot {
    
  var id: UUID?
  var benefitID: Benefit.ID
  var companyID: Company.ID
  
  static let leftIDKey: LeftIDKey = \.benefitID
  static let rightIDKey: RightIDKey = \.companyID
  
  typealias Left = Benefit
  typealias Right = Company
  
  init(_ benefitID: Benefit.ID, _ companyID: Company.ID) {
    self.benefitID = benefitID
    self.companyID = companyID
  }
}

extension BenefitCompanyPivot: Migration {}
