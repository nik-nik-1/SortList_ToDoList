//
//  ToDoListTableView.swift
//  SortList
//
//  Created by Vitaly on 2/1/16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

protocol ToDoListTableViewDelegate {
    func didTouchMoreButtonForController(item toDoItem: ToDoItem?)
}


class ToDoListTableView: UITableView, UITableViewDataSource, UITableViewDelegate, ToDoItemTableViewCellDelegate {

//    var toDoItems: [ToDoItem] = [] {
//        didSet {
//            self.reloadData()
//        }
//    }
    
    var toDoListDelegate: ToDoListTableViewDelegate?
    
    var toDoItems: [ToDoItem] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.registerClass(ToDoItemTableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.dataSource = self
        self.delegate = self
    }
    
    
    // MARK: UITableView datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.dequeueReusableCellWithIdentifier("ToDoItemTableViewCell") as? ToDoItemTableViewCell
        
        if (cell == nil) {
            // Load the nib and assign an owner
            let topLevelObjects = NSBundle.mainBundle().loadNibNamed("ToDoItemTableViewCell", owner: self, options: nil);
            cell = topLevelObjects.first as? ToDoItemTableViewCell
        }
        
        cell?.delegate = self
        
        return cell!
    }
    
    
    // MARK: UITableView delegate
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        // TODO: check on version if not iOS7 then return
        if cell.respondsToSelector("setSeparatorInset:") {
            cell.separatorInset = UIEdgeInsetsZero
        }
        
        if cell.respondsToSelector("setLayoutMargins:") {
            cell.layoutMargins = UIEdgeInsetsZero
        }
        
        if cell.respondsToSelector("setPreservesSuperviewLayoutMargins:") {
            cell.preservesSuperviewLayoutMargins = false
        }
        
        let toDoItemCell = cell as! ToDoItemTableViewCell
        let toDoItem = toDoItems[indexPath.row]
        
        toDoItemCell.toDoItem = toDoItem
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected row: \(indexPath.row), value: \(toDoItems[indexPath.row])")
    }
    
    // MARK: UITableViewCell delegate
    
    func didTouchMoreButton(cell: UITableViewCell?) {
        if (cell != nil) {
            let toDoItem = (cell as! ToDoItemTableViewCell).toDoItem
            toDoListDelegate?.didTouchMoreButtonForController(item: toDoItem)
        }
    }

}
