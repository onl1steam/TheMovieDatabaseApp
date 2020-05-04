//
//  RLMGenres.swift
//  TheMovieDatabasePersistence
//
//  Created by Рыжков Артем on 14.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import RealmSwift

/// Модель Realm для информации о жанрах
public class RLMGenres: RealmEntry {
    
    @objc public dynamic var id: Int = 0
    @objc public dynamic var name: String = ""
    
    public override class func primaryKey() -> String? {
        let primaryKey = "id"
        return primaryKey
    }
}
