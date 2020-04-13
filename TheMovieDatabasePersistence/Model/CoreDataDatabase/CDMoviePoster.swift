//
//  CDMoviePoster.swift
//  TheMovieDatabasePersistence
//
//  Created by Рыжков Артем on 14.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import CoreData

@objc(CDMoviePoster)
class CDMoviePoster: NSManagedObject {
    
    @NSManaged var posterPath: Int
    @NSManaged var image: Data
}
