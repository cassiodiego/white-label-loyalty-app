import FluentMySQL
import Vapor
import Foundation

final class BenefitCompanyPivot: MySQLUUIDPivot {

  var id: UUID?
  var benefits_id: Benefit.ID
  var companies_id: Company.ID
  
  static let leftIDKey: LeftIDKey = \.benefits_id
  static let rightIDKey: RightIDKey = \.companies_id
  
  typealias Left = Benefit
  typealias Right = Company
  
  init(_ benefits_id: Benefit.ID, _ companies_id: Company.ID) {
    self.benefits_id = benefits_id
    self.companies_id = companies_id
  }
}

extension BenefitCompanyPivot: Migration {}
