//
//  ToDoItem.swift
//  SortList
//
//  Created by Vitaly on 3/13/16.
//  Copyright © 2016 Local. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class ToDoItem: NSManagedObject {
    
    var indexpathOfCell: NSIndexPath?
    
    private static let entityName: NSString = "ToDoItem"
    private let entityName: NSString = ToDoItem.entityName
    
    class func getEntityNameOfObject() -> String {
        return entityName as String
    }
    
    static func insertNewObjectIntoContext(context: NSManagedObjectContext) -> NSManagedObject? {
        return NSEntityDescription.insertNewObjectForEntityForName(entityName as String, inManagedObjectContext: context)
    }
    
    static func insertToDoItemWithItem(item: String?, checked: Bool?, createdDate: NSDate?, colorItem:UIColor?,  context: NSManagedObjectContext) -> NSManagedObject? {
        let toDoItem: ToDoItem = insertNewObjectIntoContext(context) as! ToDoItem
        
        toDoItem.item           = item
        toDoItem.checked        = checked ?? false
        
        toDoItem.dateTimeCreate = createdDate
        toDoItem.colorItem      = colorItem ?? self.getDefaultColorFortem()
        
        return toDoItem
    }
    
    static func rewriteToDoItemWithParameters (inout toDoItemValue: ToDoItem?, item: String?, checked: Bool?, colorItem:UIColor?){
        //toDoItemElem.setValue(selectItemSwitchView.on, forKey: "checked")
        guard toDoItemValue != nil else {
            return
        }
        
        if item != nil && toDoItemValue?.item != item{
           toDoItemValue?.item = item
        }
        if checked != nil && toDoItemValue?.checked != checked{
            toDoItemValue?.checked = checked!
        }
        if colorItem != nil && toDoItemValue?.colorItem != colorItem{
            toDoItemValue?.colorItem = colorItem
        }
    }
    

    static func allToDoItems() -> [ToDoItem]? {
        let dateSort = NSSortDescriptor(key: "dateTimeCreate", ascending: true)
//        let predicate = NSPredicate(format: "item BEGINSWITH %@", "sd")
        let array = CoreDataUtil.fetchEntity(entityName as String, predicate: nil, sortDescriptors: [dateSort]) as? [ToDoItem]
        
        return array
    }
    
}