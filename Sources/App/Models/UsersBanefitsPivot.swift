//
//  UsersBanefitsPivot.swift
//  white-label-loyalty-app
//
//  Created by Cassio Diego Tavares Campos on 05/08/20.
//  Copyright (c) 2020 Cassio Diego Tavares Campos. All rights reserved.
//

import FluentMySQL
import Vapor
import Foundation

final class UsersBanefitsPivot: MySQLUUIDPivot {
    
    static let entity = "user_has_benefits"
    
    var id: UUID?
    var users_id: User.ID
    var benefits_id: Benefit.ID
    
    static let leftIDKey: LeftIDKey = \.users_id
    static let rightIDKey: RightIDKey = \.benefits_id
    
    typealias Left = User
    typealias Right = Benefit
    
    init(_ users_id: User.ID, _ benefits_id: Benefit.ID) {
        self.users_id = users_id
        self.benefits_id = benefits_id
    }
}

extension UsersBanefitsPivot: Migration {}
