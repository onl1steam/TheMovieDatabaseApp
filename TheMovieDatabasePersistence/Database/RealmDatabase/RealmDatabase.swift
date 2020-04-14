//
//  RealmDatabase.swift
//  TheMovieDatabasePersistence
//
//  Created by Рыжков Артем on 15.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
import RealmSwift

public class RealmDatabase<DBModel: RealmEntry> {
    
    public init() {}
    
    public func persist(_ entries: [DBModel]) throws {
        let realm = try Realm()
        try autoreleasepool {
            realm.beginWrite()
            
            entries.forEach {
                realm.create(DBModel.self, value: $0, update: .all)
            }
            
            try realm.commitWrite()
        }
    }
    
    public func read() throws -> [DBModel] {
        var movieDetails = [DBModel]()
        let results = try readFromRealm()
        movieDetails.append(contentsOf: results)
        return movieDetails
    }
    
    public func erase(_ entries: [DBModel]) throws {
        let realm = try Realm()
        try autoreleasepool {
            realm.beginWrite()
            
            realm.delete(entries)
            
            try realm.commitWrite()
        }
    }
    
    public func erase() throws {
        let realm = try Realm()
        let movieDetails = try readFromRealm()
        try autoreleasepool {
            realm.beginWrite()
            
            realm.delete(movieDetails)
            
            try realm.commitWrite()
        }
    }
    
    private func readFromRealm() throws -> Results<DBModel> {
        let realm = try Realm()
        let results = realm.objects(DBModel.self)
        return results
    }
}
