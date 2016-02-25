//
//  ToDoItem.swift
//  SortList
//
//  Created by Vitaly on 2/1/16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class ToDoItem: NSObject, NSCoding {
    
    var item: String!           = ""
    var checked: Bool!          = false
    var dateTimeCreate: NSDate  = Date.from(year: 0001, month: 01, day: 00)//Date.getCurrentDate()
    
    //    var ColorModeItem : ColorMode  = ColorMode.init()
    var colorItem: UIColor      = ColorMode().getDefaultColorForItem() as UIColor
    
    
    
    init (item: String, checked: Bool?, dateTimeCreateString: String?=nil, colorItem: UIColor? = nil) {
        self.item               = item
        self.checked            = checked
        
        let dateTimeCreateInn   = dateTimeCreateString == nil ? Date.getCurrentDate() : Date.parse(dateTimeCreateString!)
        self.dateTimeCreate     = dateTimeCreateInn
        
        
        var colorItemTemp: UIColor
        if let colorItem = colorItem {
            colorItemTemp = colorItem
        } else {
            colorItemTemp = ColorMode.init().getDefaultColorForItem()//ColorMode.getDefaultColorForItem()
        }
        self.colorItem          = colorItemTemp
        
    }
    
    //MARK: for NSCoding
    
    override init() {
    }
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self.item               = aDecoder.decodeObjectForKey("item") as? String
        self.checked            = aDecoder.decodeObjectForKey("checked") as? Bool
        self.dateTimeCreate     = (aDecoder.decodeObjectForKey("dateTimeCreate") as? NSDate)!
        self.colorItem          = (aDecoder.decodeObjectForKey("colorItem") as? UIColor)!
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.item,              forKey: "item")
        aCoder.encodeObject(self.checked,           forKey: "checked")
        aCoder.encodeObject(self.dateTimeCreate,    forKey: "dateTimeCreate")
        aCoder.encodeObject(self.colorItem,         forKey: "colorItem")
    }
    
    
}
