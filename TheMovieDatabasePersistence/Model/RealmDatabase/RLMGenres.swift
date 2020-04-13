//
//  RLMGenres.swift
//  TheMovieDatabasePersistence
//
//  Created by Рыжков Артем on 14.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import RealmSwift

class RLMGenres: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
}
