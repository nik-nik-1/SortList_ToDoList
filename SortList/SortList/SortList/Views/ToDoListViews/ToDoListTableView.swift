//
//  ToDoListTableView.swift
//  SortList
//
//  Created by Vitaly on 2/1/16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

protocol ToDoListTableViewDelegate {
    
    func didTouchMoreButtonForController(item toDoItem: ToDoItem?, itemLabel: UILabel)
}

protocol SelectedRowWhitIndexDelegate {
    func SetCurentItemTextLabel (item itemText: String)
}


protocol ReloadDataInTableViewInn {
    func ReloadDataInTableViewDidInn()
}

class ToDoListTableView: UITableView, UITableViewDataSource, UITableViewDelegate, ToDoItemTableViewCellDelegate, ReloadDataInTableView  {
    
//    var toDoItems: [ToDoItem] = [] {
//        didSet {
//            self.reloadData()
//        }
//    }
    
    
    
    var toDoListDelegate: ToDoListTableViewDelegate?
    var SelectedRowDelegate: SelectedRowWhitIndexDelegate?
    var delegateToReloadDataInTableViewDidInn: ReloadDataInTableViewInn?
//    var delegateToReloadDataInTableViewDid: ReloadDataInTableView?
    
    var toDoItems: [ToDoItem] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.registerClass(ToDoItemTableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.dataSource = self
        self.delegate = self
        
        //self.delegateToReloadDataInTableViewDid =
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
    
    //MARK: controll buttton
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            toDoItems.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    
    //MARK: moveRow
    // Override to support rearranging the table view.
    func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let itemToMove = toDoItems[fromIndexPath.row]
        toDoItems.removeAtIndex(fromIndexPath.row)
        toDoItems.insert(itemToMove, atIndex: toIndexPath.row)
    }
    
    
    
    // Override to support conditional rearranging of the table view.
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
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
        let valueitemText = String(toDoItems[indexPath.row].item)
        print("selected row: \(indexPath.row), value: \(valueitemText)")
        
        SelectedRowDelegate?.SetCurentItemTextLabel(item: valueitemText)
    }
    
    // MARK: UITableViewCell delegate
    
    func didTouchMoreButton(cell: UITableViewCell?) {
        if (cell != nil) {
            let toDoItem       = (cell as! ToDoItemTableViewCell).toDoItem
            let itemLabelView  = (cell as! ToDoItemTableViewCell).itemLabelView as UILabel
           // toDoListDelegate?.didTouchMoreButtonForController(item: toDoItem, itemLabel: itemLabelView)
            toDoListDelegate?.didTouchMoreButtonForController(item: toDoItem, itemLabel: itemLabelView)
        }
    }
    //MARK: ReloadDataInTableView from ActionSheetCellControls
    func ReloadDataInTableViewDid () {
        delegateToReloadDataInTableViewDidInn?.ReloadDataInTableViewDidInn()
    }

}

//extension ToDoListTableView: UITableViewController {
//}

