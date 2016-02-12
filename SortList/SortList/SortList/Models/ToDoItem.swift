//
//  ToDoItem.swift
//  SortList
//
//  Created by Vitaly on 2/1/16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class ToDoItem {

    var item: String!           = ""
    var checked: Bool!          = false
    var dateTimeCreate: NSDate  = Date.from(year: 0001, month: 01, day: 00)//Date.getCurrentDate()
    
    init (item: String, checked: Bool?, dateTimeCreateString: String?=nil) {
        self.item               = item
        self.checked            = checked
        
        let dateTimeCreateInn   = dateTimeCreateString == nil ? Date.getCurrentDate() : Date.parse(dateTimeCreateString!)
        self.dateTimeCreate     = dateTimeCreateInn
    }
}
