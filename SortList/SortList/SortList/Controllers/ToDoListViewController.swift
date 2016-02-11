//
//  ViewController.swift
//  SortList
//
//  Created by Vitaly on 2/1/16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController, ToDoListTableViewDelegate, DataEnteredDelegate, SelectedRowWhitIndexDelegate { //,UITableViewController, ToDoItemforListControllerDelegate
    
    var toDoItems: [ToDoItem] = []
    //var newItem: String = ""
    var recivedFromMainListValue: String = ""
    
    @IBOutlet weak var editButtonPanell: UIBarButtonItem!
    @IBOutlet weak var toDoListTableView: ToDoListTableView!
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetailViewController" {
            let detailViewController = segue.destinationViewController as! DetailViewControllerProtocol
            detailViewController.detailDelegate = self
            
            // set a variable in the second view controller with the String to pass
            detailViewController.receivedString = recivedFromMainListValue
        }
    }
    
    
    // MARK: DataEnteredDelegate functions
    func userDidEnterInformation(info: String) {
        //        let item3_testSearch: ToDoItem = ToDoItem(item: info, checked: true)
        //        let ddddd = toDoItems.indexOf{$0 === item3_testSearch}
        
        let filteredItems = toDoItems.filter({(itemElement : ToDoItem) -> Bool in
            return itemElement.item.lowercaseString.containsString(recivedFromMainListValue.lowercaseString)
        })//info.lowercaseString
        
        if filteredItems.count == 1 {
            //toDoItems
            filteredItems [0].item = info
            ereseuserEnterInformation ()
        }else{
            toDoItems.append(ToDoItem.init(item: info, checked: false))
        }
        
    }
    
    func ereseuserEnterInformation (){
        recivedFromMainListValue = ""
    }
    
    //MARK: SelectedRowWhitIndexDelegate function
    func SetCurentItemTextLabel (item itemText: String) {
        recivedFromMainListValue = itemText
    }
    
    //MARK: Native functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toDoItem1 = ToDoItem.init(item: "Value 1", checked: true)
        let toDoItem2 = ToDoItem.init(item: "Value 2", checked: false)
        let toDoItem3 = ToDoItem.init(item: "Value 3", checked: true)
        
        toDoItems.append(toDoItem1)
        toDoItems.append(toDoItem2)
        toDoItems.append(toDoItem3)
        
        toDoListTableView.toDoListDelegate = self;
        
        toDoListTableView.SelectedRowDelegate = self
//        toDoListTableView.delegateListController
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        toDoListTableView.toDoItems = toDoItems
        toDoListTableView.reloadData()
    }
    
    //MARK: delegate Button Click
//    func didTouchMoreButtonForController(item toDoItem: ToDoItem?) {
//        if (toDoItem != nil) {
//            let myActionSheet = ButtonActionSheetCellItems(toDoItem?.item) as UIAlertController!
//            self.presentViewController(myActionSheet, animated: true, completion: nil)
//        }
//    }
    func didTouchMoreButtonForController(item toDoItem: ToDoItem?, itemLabel: UILabel) {
        if (toDoItem != nil) {
            let myActionSheet = ButtonActionSheetCellItems(toDoItem, itLabel: itemLabel) as UIAlertController!
            self.presentViewController(myActionSheet, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func editButtonTouched(sender: AnyObject) {
        toDoListTableView.setEditing(toDoListTableView.editing ? false : true, animated: true)
        //toDoListTableView.Mov
    }
    
    //MARK: protocol buttonCheckActionSheetCellItems
//    func CheckButtonFromActionSheetCellItemsPressed () {
//        chaingeTextNarrovIfCheckedOrNot(true, itemLabel: self.itemLabelView)
//    }
    
//    func chaingeTextNarrovIfCheckedOrNot (needCheck: Bool, itemLabel:UILabel) -> Bool {
//        //retern TRUE if all OK
//        let ValueToReturn: Bool = false
//        let itemName = itemLabel.text
//        // 1
//        let string = itemName! as NSString
//        let attributedString = NSMutableAttributedString(string: string as String)
//        
//        // 2
//        var firstAttributes = [NSForegroundColorAttributeName: itemLabel.tintColor, NSStrikethroughStyleAttributeName: 0]
//        
//        if needCheck {
//            firstAttributes = [NSForegroundColorAttributeName: UIColor.lightGrayColor(), NSStrikethroughStyleAttributeName: 1]
//        }
//        
//        // 3
//        attributedString.addAttributes(firstAttributes, range: string.rangeOfString(itemName!))
//        // 4
//        itemLabel.attributedText = attributedString
//        
//        return ValueToReturn
//    }
    
    /*
    @IBAction func cancel(segue:UIStoryboardSegue) {
    
    }
    
    @IBAction func done(segue:UIStoryboardSegue) {
    let itemDetailVC = segue.sourceViewController as! DetailViewController
    newItem = itemDetailVC.labelText
    
    toDoItems.append(ToDoItem.init(item: newItem, checked: false))
    }
    */
    
}

