//
//  RLMMoviePoster.swift
//  TheMovieDatabasePersistence
//
//  Created by Рыжков Артем on 14.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import RealmSwift

public class RLMMoviePoster: Object {
    
    @objc public dynamic var posterPath = ""
    @objc public dynamic var image = Data()
}
