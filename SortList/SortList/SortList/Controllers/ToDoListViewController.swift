//
//  ViewController.swift
//  SortList
//
//  Created by Vitaly on 2/1/16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController {

    
    @IBOutlet weak var toDoListTableView: ToDoListTableView!
    
    var toDoItems: [ToDoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let toDoItem1 = ToDoItem.init(item: "Value 1", checked: true)
        
        toDoItems.append(toDoItem1)
    }

    override func viewWillAppear(animated: Bool) {
        toDoListTableView.toDoItems = toDoItems
        toDoListTableView.reloadData()
    }
    

}

