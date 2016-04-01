//
//  ViewController.swift
//  SortList
//
//  Created by Vitaly on 2/1/16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController, ToDoListTableViewDelegate, ToDoItemActionSheetControlDelegate, DataEnteredDelegate{
    
    var toDoItems: [ToDoItem] = [] {
        didSet {
            toDoListTableView.toDoItems = toDoItems
            toDoListTableView.reloadData()
            //
//            toggleTableEditingMode()
            enableDisableEditButton()
        }
    }
    var recivedFromMainListValueCell: ToDoItem? = nil
    
    @IBOutlet weak var editButtonPanell: UIBarButtonItem!
    @IBAction func editButtonTouched(sender: AnyObject) {
        toggleTableEditingMode()
    }

    @IBOutlet weak var toDoListTableView: ToDoListTableView!
    @IBAction func buttonGoBackToMenuList(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: Native functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let loadedtoDoItemData = NSUserDefaults.standardUserDefaults().objectForKey("toDoItemData") as? NSData {
//            if let toDoItemArray = NSKeyedUnarchiver.unarchiveObjectWithData(loadedtoDoItemData) as? [ToDoItem] {
//                for itemS in toDoItemArray {
//                    toDoItems.append(itemS)
//                }
//            } else {
//                setDefaultData ()
//            }
//        } else {
//            setDefaultData ()
//        }
          toDoListTableView.toDoListDelegate = self;
    }
    
//    func setDefaultData () {
//        
//    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController!.navigationBar.barTintColor = UIColor.whiteColor()//
        self.navigationController?.navigationBar.alpha = 1
        
        if let items = ToDoItem.allToDoItems() {
            toDoItems = items
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetailViewController" {
            let detailViewController = segue.destinationViewController as! DetailViewController
            // set a variable in the second view controller with the String to pass
            //detailViewController.receivedString = recivedFromMainListValue
            detailViewController.receivedCell = recivedFromMainListValueCell//! as ToDoItem
            detailViewController.detailDelegate = self

        }
    }
    
    
    func getTitleValueFromMainListValueCell () -> String {
        guard recivedFromMainListValueCell != nil else {
            return ""
        }
        
        return (recivedFromMainListValueCell?.item)! as String
    }
    
    
    func ereseuserEnterInformation (){
        recivedFromMainListValueCell = nil
    }
    
    
    //MARK: SelectedRowWhitIndexDelegate function
    func setCurentItemTextLabel (item: ToDoItem) {
        recivedFromMainListValueCell = item
    }
    
    func didTouchMoreButtonForController(item toDoItemElem: ToDoItem?, itemLabel: UILabel) {
        if (toDoItemElem != nil) {
            let toDoItemActionSheet = ToDoItemActionSheetControl(title: toDoItemElem?.item, message: "", preferredStyle:.ActionSheet)
            toDoItemActionSheet.toDoItemElem = toDoItemElem
            toDoItemActionSheet.delegate = self
            self.presentViewController(toDoItemActionSheet, animated: true, completion: nil)
        }
    }
    
    
    func didChangeAction() {
        toDoListTableView.reloadData()
    }
    
    
    
    // toggle table editing mode
    private func toggleTableEditingMode() {
        let tBool: Bool = toDoListTableView.editing
        if tBool {
            editButtonPanell.title = "Edit"

        }else{
            editButtonPanell.title = "Done"
        }
        toDoListTableView.setEditing(tBool ? false : true, animated: true)
    }
    
    // disable edit button if no record
    private func enableDisableEditButton() {
        if toDoItems.count == 0 {
            editButtonPanell.enabled = false
        }else{
            editButtonPanell.enabled = true
        }
    }

    
}

