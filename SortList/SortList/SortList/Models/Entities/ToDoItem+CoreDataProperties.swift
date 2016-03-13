//
//  ToDoItem+CoreDataProperties.swift
//  SortList
//
//  Created by Vitaly on 3/13/16.
//  Copyright © 2016 Local. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ToDoItem {

    @NSManaged var item: String?
    @NSManaged var checked: NSNumber?
    @NSManaged var dateTimeCreate: NSDate?
    @NSManaged var colorItem: NSObject?

}
