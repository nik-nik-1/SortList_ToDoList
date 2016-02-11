//
//  ButtonActionSheetCellController.swift
//  SortList
//
//  Created by mc373 on 05.02.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class ActionSheetCellControl: UIButton {
    
}

//protocol buttonActiveActionSheetCellItems : class {
//
//    func CheckButtonFromActionSheetCellItemsPressed ()
//
//}

func ButtonActionSheetCellItems(toDoItem: ToDoItem?, itLabel: UILabel) -> UIAlertController {// (title: String?)
    
    //    weak var ButtonPressedDelegate: buttonActiveActionSheetCellItems? = nil
    let title       = toDoItem!.item as String//itLabel.text
    var itemChecked = toDoItem!.checked as Bool
    
    let myActionSheet = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
    
    
    let buttonArchive = UIAlertAction(title: "Archive", style: UIAlertActionStyle.Default) {
        (ACTION) in
        print("Archive button tapped")
    }
    let buttonDelete = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Default) {
        (ACTION) in
        print("Delete button tapped")
    }
    
    
    //    let buttonCheck = UIAlertAction (title: "Check", style: UIAlertActionStyle.Default) {
    //        (ACTION) in
    //        print("Check button tapped")
    ////        ButtonPressedDelegate?.CheckButtonFromActionSheetCellItemsPressed()
    //        chaingeTextNarrovIfCheckedOrNot (true, itemLabel: itLabel)
    //    }
    
    let titleChekenUnCheked: String = (itemChecked ? "Un check" : "Check")
    
//    if itemChecked {
//        titleChekenUnCheked = "Un check"
//    }else{
//        titleChekenUnCheked = "Check"
//    }
    let buttonCheck = UIAlertAction (title: titleChekenUnCheked, style: UIAlertActionStyle.Default) {
        (ACTION) in
        print("\(titleChekenUnCheked) button tapped")
        //        ButtonPressedDelegate?.CheckButtonFromActionSheetCellItemsPressed()
        
        toDoItem!.checked = !itemChecked
        chaingeTextNarrovIfCheckedOrNot (!itemChecked, itemLabel: itLabel)
            }
    
    
    let buttonAllItems = UIAlertAction (title: "All items", style: UIAlertActionStyle.Default) {
        (ACTION) in
        print("All items button tapped")
    }
    let buttonRemind = UIAlertAction (title: "Remind", style: UIAlertActionStyle.Default) {
        (ACTION) in
        print("All items button tapped")
        
    }
    let buttonBlock = UIAlertAction (title: "Block", style: UIAlertActionStyle.Default) {
        (ACTION) in
        print("Block button tapped")
    }
    let buttonCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
        (ACTION) in
        print("Cancel button tapped")
    }
    
    myActionSheet.addAction(buttonArchive)
    myActionSheet.addAction(buttonDelete)
    myActionSheet.addAction(buttonCheck)
    myActionSheet.addAction(buttonAllItems)
    myActionSheet.addAction(buttonRemind)
    myActionSheet.addAction(buttonBlock)
    myActionSheet.addAction(buttonCancel)
    
    return myActionSheet
    
}

func chaingeTextNarrovIfCheckedOrNot (needCheck: Bool, itemLabel: UILabel) -> Bool {
    //retern TRUE if all OK
    let ValueToReturn: Bool = false
    let itemName = itemLabel.text
    // 1
    let string = itemName! as NSString
    let attributedString = NSMutableAttributedString(string: string as String)
    
    // 2
//    var firstAttributes = [NSForegroundColorAttributeName: itemLabel.tintColor, NSStrikethroughStyleAttributeName: 0]
    
    if needCheck {
        let firstAttributes = [NSForegroundColorAttributeName: UIColor.lightGrayColor(), NSStrikethroughStyleAttributeName: 1]
         attributedString.addAttributes(firstAttributes, range: string.rangeOfString(itemName!))
    }else{
       let firstAttributes = [NSForegroundColorAttributeName: itemLabel.tintColor, NSStrikethroughStyleAttributeName: 0]
         attributedString.addAttributes(firstAttributes, range: string.rangeOfString(itemName!))
    }

    // 3
//    attributedString.addAttributes(firstAttributes?, range: string.rangeOfString(itemName!))
    // 4
    itemLabel.attributedText = attributedString
    
    return ValueToReturn
}

