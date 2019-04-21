//
//  HerokuStorage.swift
//  AnyGIS_ServerPackageDescription
//
//  Created by HR_book on 21/04/2019.
//

import FluentSQLite
import Vapor

final class Record: SQLiteModel {
    
    var id: Int?
    var title: String
    var unixTime: Int
    var data: String
    
    init(id: Int? = nil, title: String, unixTime: Int, data: String) {
        self.id = id
        self.title = title
        self.unixTime = unixTime
        self.data = data
    }
}


/// Allows `Record` to be used as a dynamic migration.
extension Record: Migration { }

/// Allows `Record` to be encoded to and decoded from HTTP messages.
extension Record: Content { }

/// Allows `Record` to be used as a dynamic parameter in route definitions.
extension Record: Parameter { }

extension Record: Codable { }
