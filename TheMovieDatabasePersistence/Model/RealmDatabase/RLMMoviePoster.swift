//
//  RLMMoviePoster.swift
//  TheMovieDatabasePersistence
//
//  Created by Рыжков Артем on 14.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import RealmSwift

class RLMMoviePoster: Object {
    
    @objc dynamic var posterPath = ""
    @objc dynamic var image = Data()
}
