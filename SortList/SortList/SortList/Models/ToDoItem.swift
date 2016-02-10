//
//  ToDoItem.swift
//  SortList
//
//  Created by Vitaly on 2/1/16.
//  Copyright © 2016 Local. All rights reserved.
//


class ToDoItem {

    var item: String! = ""
    var checked: Bool! = false
    
    init (item: String, checked: Bool?) {
        self.item = item
        self.checked = checked
    }
}
