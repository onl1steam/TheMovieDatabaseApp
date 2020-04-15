//
//  CoreDataEntry.swift
//  TheMovieDatabasePersistence
//
//  Created by Рыжков Артем on 15.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import CoreData
import Foundation

@objc(CoreDataEntry)
public class CoreDataEntry: NSManagedObject {
    
    public class var entryName: String {
        let name = NSStringFromClass(Self.self).components(separatedBy: ".").last!
        return name
    }
    
    @NSManaged public var entryId: String
}
