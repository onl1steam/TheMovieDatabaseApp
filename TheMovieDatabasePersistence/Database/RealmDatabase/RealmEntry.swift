//
//  Entry.swift
//  TheMovieDatabasePersistence
//
//  Created by Рыжков Артем on 15.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import Foundation
import RealmSwift

public class RealmEntry: Object {
    
    public override class func primaryKey() -> String? {
        let primaryKey = "id"
        return primaryKey
    }
}
