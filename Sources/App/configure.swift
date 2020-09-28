//
//  configure.swift
//  white-label-loyalty-app
//
//  Created by Cassio Diego Tavares Campos on 05/08/20.
//  Copyright (c) 2020 Cassio Diego Tavares Campos. All rights reserved.
//

import FluentMySQL
import Vapor
import Authentication

/// Called before application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    
    /// Register providers first
    try services.register(FluentMySQLProvider())
    try services.register(AuthenticationProvider())
    
    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    /// Register middleware
    var middlewares = MiddlewareConfig()
    middlewares.use(FileMiddleware.self)
    middlewares.use(ErrorMiddleware.self)
    middlewares.use(SessionsMiddleware.self)
    services.register(middlewares)
    
    /// Database  configurations
    let databaseConfig = MySQLDatabaseConfig(hostname: "localhost",
                                             port: 3306,
                                             username: "white-label-loyalty-db",
                                             password: "white-label-loyalty-db",
                                             database: "white-label-loyalty-db")
    
    let database = MySQLDatabase(config: databaseConfig)
    var databases = DatabasesConfig()
    databases.add(database: database, as: .mysql)
    services.register(databases)
    
    /// Register tables to the database
    User.defaultDatabase = .mysql
    Token.defaultDatabase = .mysql
    Company.defaultDatabase = .mysql
    Benefit.defaultDatabase = .mysql
    BenefitCompanyPivot.defaultDatabase = .mysql
    UsersBanefitsPivot.defaultDatabase = .mysql
    
    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Benefit.self, database: .mysql)
    migrations.add(model: User.self, database: .mysql)
    migrations.add(model: Company.self, database: .mysql)
    migrations.add(model: UsersBanefitsPivot.self, database: .mysql)
    migrations.add(model: Token.self, database: .mysql)
    
    services.register(migrations)
    
    config.prefer(MemoryKeyedCache.self, for: KeyedCache.self)
}
