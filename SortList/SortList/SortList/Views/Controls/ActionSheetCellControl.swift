//
//  ButtonActionSheetCellController.swift
//  SortList
//
//  Created by mc373 on 05.02.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

//protocol ButtonActionSheetCellDegate {
//    func didPressButton(button:UIButton)
//}
//
//class ButtonActionSheetCellController: UIButton {
//    
//    var delegate:ButtonActionSheetCellDegate!
//    
//    override init(frame:CGRect) {
//        super.init(frame:frame)
//        
////        var button = UIButton()
////        button.setTitle("...", forState: .Normal)
////        button.addTarget(self, action: "buttonPress:", forControlEvents: .TouchUpInside)
////        self.addSubview(button)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func buttonPress(button:UIButton) {
//        delegate.didPressButton(button)
//    }
//    
//}


//class ButtonActionSheetCellController: UIButton {
//
//  func ButtonActionSheetCellTappet(sender: AnyObject, title: String?) {
//        
//        let myActionSheet = UIAlertController (title: title, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
//        
//    
//        
//        let buttonArchive = UIAlertAction (title: "Archive", style: UIAlertActionStyle.Default) {
//            (ACTION) in
//            print("Archive button tapped")
//        }
//        let buttonDelete = UIAlertAction (title: "Delete", style: UIAlertActionStyle.Default) {
//            (ACTION) in
//            print("Delete button tapped")
//        }
//        let buttonCheck = UIAlertAction (title: "Check", style: UIAlertActionStyle.Default) {
//            (ACTION) in
//            print("Check button tapped")
//        }
//        let buttonAllItems = UIAlertAction (title: "All items", style: UIAlertActionStyle.Default) {
//            (ACTION) in
//            print("All items button tapped")
//        }
//        let buttonRemind = UIAlertAction (title: "Remind", style: UIAlertActionStyle.Default) {
//            (ACTION) in
//            print("All items button tapped")
//            
//        }
//        let buttonBlock = UIAlertAction (title: "Block", style: UIAlertActionStyle.Default) {
//            (ACTION) in
//            print("Block button tapped")
//        }
//        let buttonCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
//            (ACTION) in
//            print("Cancel button tapped")
//        }
//        
//        myActionSheet.addAction(buttonArchive)
//        myActionSheet.addAction(buttonDelete)
//        myActionSheet.addAction(buttonCheck)
//        myActionSheet.addAction(buttonAllItems)
//        myActionSheet.addAction(buttonRemind)
//        myActionSheet.addAction(buttonBlock)
//        myActionSheet.addAction(buttonCancel)
//        
//        // self.presentViewController(myActionSheet, animated: true, completion: nil)
//        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(myActionSheet, animated: true, completion: nil)
//    }
//    
//}

func ButtonActionSheetCellItems(title: String?) -> UIAlertController {
    
    let myActionSheet = UIAlertController(title: title, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
    
    
    
    let buttonArchive = UIAlertAction(title: "Archive", style: UIAlertActionStyle.Default) {
        (ACTION) in
        print("Archive button tapped")
    }
    let buttonDelete = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Default) {
        (ACTION) in
        print("Delete button tapped")
    }
    let buttonCheck = UIAlertAction (title: "Check", style: UIAlertActionStyle.Default) {
        (ACTION) in
        print("Check button tapped")
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

