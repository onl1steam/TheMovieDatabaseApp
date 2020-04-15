//
//  CDInstanceCreator.swift
//  TheMovieDatabasePersistence
//
//  Created by Рыжков Артем on 15.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import CoreData
import Foundation

public protocol CDInstanceCreator {
    
    func createInstances(context: NSManagedObjectContext)
}
