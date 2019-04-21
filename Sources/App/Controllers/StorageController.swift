//
//  SQLHandler.swift
//  App
//
//  Created by HR_book on 21/04/2019.
//

import Vapor
import FluentSQLite

class StorageController {
    
    
    // MARK: GET
    
    func getAll(_ req: Request) throws -> Future<[Storage]> {
        return Storage
            .query(on: req)
            .sort(\.unixTime, .ascending)
            .all()
    }
    
    
    
    
    func getAllByTitle(_ req: Request) throws -> Future<[Storage]>  {
        
        let title = try req.parameters.next(String.self)
        
        return Storage
            .query(on: req)
            .filter(\Storage.data == title)
            .sort(\.unixTime, .ascending)
            .all()
    }
    
    
    
    
    func getLastByTitle(_ req: Request) throws -> Future<Storage>  {
        
        let title = try req.parameters.next(String.self)
        
        return Storage
            .query(on: req)
            .filter(\Storage.data == title)
            .sort(\.unixTime, .ascending)
            .first()
            .unwrap(or: Abort.init(
                HTTPResponseStatus.custom(code: 501, reasonPhrase: "Uwarping MapData error")))
    }
    
    
    
    
    func getById(_ req: Request) throws -> Future<Storage> {
        
        let objectId = try req.parameters.next(Int.self)
        
        return Storage
            .find(objectId, on: req)
            .map(to: Storage.self) { record in
                guard let record = record else { throw Abort.init(HTTPStatus.notFound) }
                return record
        }
    }
    
    
    
    
    
    
    // MARK: POST
    
    
    func create(_ req: Request) throws -> Future<Storage> {
        return try req.content.decode(Storage.self).flatMap { record in
            return record.save(on: req)
        }
    }
    
    
    
 
    
    func restoreFromJson(_ req: Request) throws -> Future<HTTPStatus> {
        
        // Parse and check records received JSON
        return try req.content.decode([Storage].self).map { records -> HTTPStatus in
        
            // If ok, then clean all records from data base
            let currentUnixTime = Int(Date().timeIntervalSince1970)
            self.eraseAllOlderThat(timestamp: currentUnixTime, req)
            
            // And add new record to it
            records.map {
                $0.save(on: req)
            }
            
            return HTTPStatus.init(statusCode: 200)
        }
    }
    
    
    
    
    
    
    // MARK: DELETE
    
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Storage.self).flatMap { record in
            return record.delete(on: req)
            }.transform(to: .ok)
    }
    
    
    
    func deleteById(_ req: Request) throws -> Future<HTTPStatus> {
        
        let objectId = try req.parameters.next(Int.self)
        
        return Storage
            .find(objectId, on: req)
            .flatMap { record -> Future<Void> in
                guard let record = record else { throw Abort.init(HTTPStatus.notFound) }
                return record.delete(on: req)
        }.transform(to: .ok)
    }
    
    
    
    func deleteLastByTitle(_ req: Request) throws -> Future<HTTPStatus> {
        
        let title = try req.parameters.next(String.self)
        
        return Storage
            .query(on: req)
            .filter(\Storage.data == title)
            .sort(\.unixTime, .ascending)
            .first()
            .unwrap(or: Abort.init(
                HTTPResponseStatus.custom(code: 501, reasonPhrase: "Uwarping MapData error")))
            .flatMap { record  -> Future<Void> in
                return record.delete(on: req)
            }.transform(to: .ok)
    }
    
    
    
    
    func deleteAllOlderThatTimestamp(_ req: Request) throws -> HTTPStatus {
        
        let timestamp = try req.parameters.next(Int.self)
        
        eraseAllOlderThat(timestamp: timestamp, req)
        
        return HTTPStatus.init(statusCode: 200)
    }
    
    
    
    
    private func eraseAllOlderThat(timestamp: Int, _ req: Request) {
        Storage
            .query(on: req)
            .filter(\Storage.unixTime <= timestamp)
            .all()
            .map { records in
                records.map { record in
                    record.delete(on: req)
                }
        }
    }
    
    
    
    func deleteAllWithTitleOlderThatTimestamp(_ req: Request) throws -> HTTPStatus {
        
        let timestamp = try req.parameters.next(Int.self)
        let title = try req.parameters.next(String.self)
        
        Storage
            .query(on: req)
            .filter(\Storage.data == title)
            .filter(\Storage.unixTime <= timestamp)
            .all()
            .map { records in
                records.map { record in
                    record.delete(on: req)
                }
        }
        
        return HTTPStatus.init(statusCode: 200)
    }
        
        
}
