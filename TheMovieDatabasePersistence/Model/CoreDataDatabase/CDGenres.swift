//
//  CDGenres.swift
//  TheMovieDatabasePersistence
//
//  Created by Рыжков Артем on 14.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import CoreData

@objc(CDGenres)
class CDGenres: NSManagedObject {
    
    @NSManaged var id: Int
    @NSManaged var name: String
}
