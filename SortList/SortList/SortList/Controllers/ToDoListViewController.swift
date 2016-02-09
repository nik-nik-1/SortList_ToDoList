//
//  ViewController.swift
//  SortList
//
//  Created by Vitaly on 2/1/16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController, ToDoListTableViewDelegate { //,UITableViewController

    var toDoItems: [ToDoItem] = []
    var newItem: String = ""

    @IBOutlet weak var editButtonPanell: UIBarButtonItem!
    @IBOutlet weak var toDoListTableView: ToDoListTableView!
    
    @IBAction func cancel(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func done(segue:UIStoryboardSegue) {
        let itemDetailVC = segue.sourceViewController as! DetailViewController
        newItem = itemDetailVC.labelText
        
        toDoItems.append(ToDoItem.init(item: newItem, checked: false))
    }
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let toDoItem1 = ToDoItem.init(item: "Value 1", checked: true)
        let toDoItem2 = ToDoItem.init(item: "Value 2", checked: false)
        let toDoItem3 = ToDoItem.init(item: "Value 3", checked: true)
        
        toDoItems.append(toDoItem1)
        toDoItems.append(toDoItem2)
        toDoItems.append(toDoItem3)
        
        toDoListTableView.toDoListDelegate = self;
       
       // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        toDoListTableView.toDoItems = toDoItems
        toDoListTableView.reloadData()
        
    }
    
    //MARK: delegate Button Click
    func didTouchMoreButtonForController(item toDoItem: ToDoItem?) {
        if (toDoItem != nil) {
            let myActionSheet = ButtonActionSheetCellItems(toDoItem?.item) as UIAlertController!
            self.presentViewController(myActionSheet, animated: true, completion: nil)
        }
    }

    
    @IBAction func editButtonTouched(sender: AnyObject) {
        toDoListTableView.setEditing(toDoListTableView.editing ? false : true, animated: true)
        
    }
    
    
}

