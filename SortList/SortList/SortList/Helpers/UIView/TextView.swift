//
//  TextView.swift
//  SortList
//
//  Created by mc373 on 08.04.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class TextView{
   
    class func changeTextNarrovIfCheckedOrNot(toDoItemElem:ToDoItem, itemLabelView:UILabel) {
        let attributedString = NSMutableAttributedString(string: toDoItemElem.item!)
        
        var firstAttributes: NSDictionary
        if toDoItemElem.checked as Bool {
            firstAttributes = [NSForegroundColorAttributeName: UIColor.lightGrayColor(), NSStrikethroughStyleAttributeName: 1]
        } else {
            firstAttributes = [NSForegroundColorAttributeName: itemLabelView.tintColor, NSStrikethroughStyleAttributeName: 0]
        }
        
        let itemString = NSString(string: toDoItemElem.item!)
        
        attributedString.addAttributes(firstAttributes as! [String : AnyObject], range: itemString.rangeOfString(toDoItemElem.item!))
        
        itemLabelView.attributedText = attributedString
    }
}