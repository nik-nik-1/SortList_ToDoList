//
//  ViewController.swift
//  SortList
//
//  Created by Vitaly on 2/1/16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController, ToDoListTableViewDelegate,ToDoItemActionSheetControlDelegate {
    
    var toDoItems: [ToDoItem] = [] {
        didSet {
            toDoListTableView.toDoItems = toDoItems
            toDoListTableView.reloadData()
        }
    }
    var recivedFromMainListValueCell: ToDoItem? = nil
    
    @IBOutlet weak var editButtonPanell: UIBarButtonItem!
    @IBOutlet weak var toDoListTableView: ToDoListTableView!
    
    //MARK: Native functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let defaults = NSUserDefaults.standardUserDefaults()
        if let toDoItemData = defaults.stringForKey("toDoItemData")
        {
        println(name)
        }*/
        
        if let loadedtoDoItemData = NSUserDefaults.standardUserDefaults().objectForKey("toDoItemData") as? NSData {
            if let toDoItemArray = NSKeyedUnarchiver.unarchiveObjectWithData(loadedtoDoItemData) as? [ToDoItem] {
                for itemS in toDoItemArray {
                    toDoItems.append(itemS)
                }
            }else{
                setDefaultData ()
            }
        }else{
            setDefaultData ()
        }
        
        
        
        toDoListTableView.toDoListDelegate = self;
        
        //        toDoListTableView.SelectedRowDelegate = self
        
        //        toDoListTableView.delegateListController
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    func setDefaultData () {

    }
    
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
        }
    }
    
    
    func getTitleValueFromMainListValueCell () -> String {
        guard recivedFromMainListValueCell != nil else {
            return ""
        }
        
        return ((recivedFromMainListValueCell?.item)! as String)
    }
    
    func ereseuserEnterInformation (){
        //recivedFromMainListValue = ""
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
    
    @IBAction func editButtonTouched(sender: AnyObject) {
        toDoListTableView.setEditing(toDoListTableView.editing ? false : true, animated: true)
        //toDoListTableView.Mov
        
        
    }
    

    
}

