//
//  RealmDatabase.swift
//  TheMovieDatabasePersistence
//
//  Created by Рыжков Артем on 15.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
import RealmSwift

/// База данных Realm
public class RealmDatabase<Model: RealmEntry> {
    
    public init() {}
    
    /// Сохраняет массив данных типа Model в базу данных
    ///
    /// - Parameters:
    ///     - entries: Массив данных.
    public func persist(_ entries: [Model]) throws {
        let realm = try Realm()
        try autoreleasepool {
            realm.beginWrite()
            
            entries.forEach {
                realm.create(Model.self, value: $0, update: .all)
            }
            
            try realm.commitWrite()
        }
    }
    
    /// Загружает из базы данных массив данных типа Model
    public func read() throws -> [Model] {
        var movieDetails = [Model]()
        let results = try readFromRealm()
        movieDetails.append(contentsOf: results)
        return movieDetails
    }
    
    /// Удаляет из базы данных записи модели Model
    ///
    /// - Parameters:
    ///     - entries: Массив данных, которые надо удалить.
    public func erase(_ entries: [Model]) throws {
        let realm = try Realm()
        try autoreleasepool {
            realm.beginWrite()
            
            realm.delete(entries)
            
            try realm.commitWrite()
        }
    }
    
    /// Удаляет из базы данных все записи модели Model
    public func erase() throws {
        let realm = try Realm()
        let modelData = try readFromRealm()
        try autoreleasepool {
            realm.beginWrite()
            
            realm.delete(modelData)
            
            try realm.commitWrite()
        }
    }
    
    private func readFromRealm() throws -> Results<Model> {
        let realm = try Realm()
        let results = realm.objects(Model.self)
        return results
    }
}
