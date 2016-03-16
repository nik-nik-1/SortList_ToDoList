//
//  ToDoItem.swift
//  SortList
//
//  Created by Vitaly on 3/13/16.
//  Copyright © 2016 Local. All rights reserved.
//

import Foundation
import CoreData


class ToDoItem: NSManagedObject {
    
    private let entityName: NSString = "ToDoItem"

    static func insertNewObjectIntoContext(context: NSManagedObjectContext) -> NSManagedObject? {
        return NSEntityDescription.insertNewObjectForEntityForName("ToDoItem", inManagedObjectContext: context)
    }
    
    static func insertToDoItemWithItem(item: String?, checked: Bool?, createdDate: NSDate?,  context: NSManagedObjectContext) -> NSManagedObject? {
        let toDoItem: ToDoItem = insertNewObjectIntoContext(context) as! ToDoItem
        
        toDoItem.item = item
        toDoItem.checked = checked ?? false
        
        toDoItem.dateTimeCreate = createdDate
        
        return toDoItem
    }

    static func allToDoItems() -> [ToDoItem]? {
        let dateSort = NSSortDescriptor(key: "dateTimeCreate", ascending: true)
//        let predicate = NSPredicate(format: "item BEGINSWITH %@", "sd")
        let array = CoreDataUtil.fetchEntity("ToDoItem", predicate: nil, sortDescriptors: [dateSort]) as? [ToDoItem]
        
        return array
    }
    
}
