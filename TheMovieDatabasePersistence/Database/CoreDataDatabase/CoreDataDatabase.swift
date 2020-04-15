//
//  CoreDataDatabase.swift
//  TheMovieDatabasePersistence
//
//  Created by Рыжков Артем on 15.04.2020.
//  Copyright © 2020 Рыжков Артем. All rights reserved.
//

import CoreData
import Foundation

public class CoreDataDatabase<Model: CoreDataEntry> {
    
    private var creator: CDInstanceCreator?
    
    public init(creator: CDInstanceCreator?) {
        self.creator = creator
    }
    
    private var context: NSManagedObjectContext {
        let context = Thread.isMainThread
            ? NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            : NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = NSPersistentStoreCoordinator()
        context.shouldDeleteInaccessibleFaults = true
        context.automaticallyMergesChangesFromParent = true
        return context
    }
    
    public func persist() throws {
        let context = self.context
        creator?.createInstances(context: context)
        do {
            try context.save()
        } catch {
            context.rollback()
        }
    }
    
    public func read() throws -> [Model] {
        let request = NSFetchRequest<Model>(entityName: Model.entryName)
        
        let entries = try context.fetch(request)
        
        return entries
    }
    
    public func erase() {
        
        if let result = try? read() {
            for object in result {
                context.delete(object)
            }
        }
    }
    
    private func request(_ entryId: String) -> NSFetchRequest<Model> {
        let request = NSFetchRequest<Model>(entityName: Model.entryName)
        request.predicate = NSPredicate(format: "entryId == %@", argumentArray: [entryId])
        
        return request
    }
    
    private func fetchEntries(
        _ entryId: String,
        inContext context: NSManagedObjectContext) -> [Model] {
        
        let request = self.request(entryId)
        let entries = try? context.fetch(request)
        return entries ?? []
    }
    
    private func isEntryExist(
        _ entryId: String,
        inContext context: NSManagedObjectContext) -> Bool {
        
        let existingEntries = fetchEntries(entryId, inContext: context)
        return existingEntries.isEmpty
    }
}
