//
//  CDMoviePoster.swift
//  TheMovieDatabasePersistence
//
//  Created by Рыжков Артем on 14.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import CoreData

@objc(CDMoviePoster)
public class CDMoviePoster: NSManagedObject {
    
    @NSManaged public var posterPath: String
    @NSManaged public var image: Data
}
