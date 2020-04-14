//
//  CDGenres.swift
//  TheMovieDatabasePersistence
//
//  Created by Рыжков Артем on 14.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import CoreData

@objc(CDGenres)
public class CDGenres: NSManagedObject {
    
    @NSManaged public var id: Int
    @NSManaged public var name: String
}