//
//  ViewController.swift
//  SortList
//
//  Created by Vitaly on 2/1/16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController, ToDoListTableViewDelegate {

    
    @IBOutlet weak var toDoListTableView: ToDoListTableView!
    
    var toDoItems: [ToDoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let toDoItem1 = ToDoItem.init(item: "Value 1", checked: true)
        let toDoItem2 = ToDoItem.init(item: "Value 2", checked: false)
        let toDoItem3 = ToDoItem.init(item: "Value 3", checked: true)
        
        toDoItems.append(toDoItem1)
        toDoItems.append(toDoItem2)
        toDoItems.append(toDoItem3)
        
        toDoListTableView.toDoListDelegate = self;
        
    }

    //MARK: delegate Button Click
    func didTouchMoreButtonForController(cell: UITableViewCell?) {
        print("didTouchMoreButtonForController")
        
//        myActionSheet = ButtonActionSheetCellItems ("Hello xz`x") as UIAlertController!
//        self.presentViewController(myActionSheet, animated: true, completion: nil)
        

    }

    
    override func viewWillAppear(animated: Bool) {
        toDoListTableView.toDoItems = toDoItems
        toDoListTableView.reloadData()
        
//        toDoListTableView.delegate = self
    }
    
    
    func didTouchMoreButtonForController(item toDoItem: ToDoItem?) {
        if (toDoItem != nil) {
            let myActionSheet = ButtonActionSheetCellItems(toDoItem?.item) as UIAlertController!
            self.presentViewController(myActionSheet, animated: true, completion: nil)
        }
    }

}

