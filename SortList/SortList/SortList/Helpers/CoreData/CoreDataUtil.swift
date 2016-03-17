//
//  CoreDataUtil.swift
//  SortList
//
//  Created by Vitaly on 3/12/16.
//  Copyright © 2016 Local. All rights reserved.
//

import CoreData

class CoreDataUtil {
    
    private static func fetchRequestForEntity(entity: String, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, otherOptions: Dictionary<String, Float>?) -> NSFetchRequest {
        
        // Get the main object context
        let moc = getManagedObjectContext()
        
        // Get the entity description
        let entityDescription = NSEntityDescription.entityForName(entity, inManagedObjectContext: moc)
        
        // Create the request
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        if (predicate != nil) {
            request.predicate = predicate
        }
        
        request.sortDescriptors = sortDescriptors
        
        if let options = otherOptions as Dictionary? {
            for (key, value) in options {
                if key == "FetchLimit" {
                    request.fetchLimit = Int(value)
                } else if key == "BatchSize" {
                    request.fetchBatchSize = Int(value)
                }
            }
        }
        return request
    }
    
    static func fetchEntity(entityName: String, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, otherOptions: Dictionary<String, Float>?) -> [AnyObject]? {
        
        // Get the main object context
        let moc = getManagedObjectContext()

        let request = self.fetchRequestForEntity(entityName, predicate: predicate, sortDescriptors: sortDescriptors, otherOptions: otherOptions)
        
        var list: [AnyObject]?
        
        do {
            list = try moc.executeFetchRequest(request)
            // success ...
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
            
            return nil
        }
        
        return list
    }
    
    static func fetchEntity(entityName: String, predicate: NSPredicate?) -> [AnyObject]? {
        return self.fetchEntity(entityName, predicate: predicate, sortDescriptors: nil, otherOptions: nil)
    }
    
    static func fetchEntity(entityName: String, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [AnyObject]? {
        return self.fetchEntity(entityName, predicate: predicate, sortDescriptors: sortDescriptors, otherOptions: nil)
    }

    static func countForEntity(entityName: String, predicate: NSPredicate) -> Int {
        // Get the main object context
        let moc = getManagedObjectContext()
        
        let request = self.fetchRequestForEntity(entityName, predicate: predicate, sortDescriptors: nil, otherOptions: nil)
        
        let error = NSErrorPointer()
        let count = moc.countForFetchRequest(request, error: error)
        
        if let e = error as NSErrorPointer? {
            print("Error returning results count: \(e). \(e.debugDescription)")
            return 0
        }
        
        return count
    }
    
    static func insertEntityNamed(entityName: String) -> AnyObject? {
        let moc = getManagedObjectContext()
        return NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: moc)
    }
    
    static func insertEntityNamed(entityName: String, context: NSManagedObjectContext) -> AnyObject? {
        return NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: context)
    }

    
    static func save(error: NSErrorPointer) {
        let moc = getManagedObjectContext()
        self.saveContext(moc)
    }
    
    static func saveContext() {
        saveContext(getManagedObjectContext())
    }
    
    static func saveContext(managedObjectContext: NSManagedObjectContext?) {
        
        guard let moc = managedObjectContext as NSManagedObjectContext! else {
            return
        }
    
        if moc.hasChanges {
            do {
                try moc.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    static func saveContextAndParentContexts(managedObjectContext: NSManagedObjectContext?) {
        self.saveContext(managedObjectContext)
        if let parentContext = managedObjectContext?.parentContext {
            self.saveContext(parentContext)
        }
    }

    static func deleteObject(object: NSManagedObject, error: NSError) {
        let moc = getManagedObjectContext()
        moc.deleteObject(object)
        
        do {
            try moc.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
    
    static func getManagedObjectContext() -> NSManagedObjectContext{
        return CoreDataManager.sharedInstance.managedObjectContext
    }
    
}

