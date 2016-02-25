//
//  ViewController.swift
//  SortList
//
//  Created by Vitaly on 2/1/16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController, ToDoListTableViewDelegate, DataEnteredDelegate,ToDoItemActionSheetControlDelegate {
    
    var toDoItems: [ToDoItem] = []
    //var newItem: String = ""
    //    var recivedFromMainListValue: String = ""
    var recivedFromMainListValueCell: ToDoItem? = nil
    
    @IBOutlet weak var editButtonPanell: UIBarButtonItem!
    @IBOutlet weak var toDoListTableView: ToDoListTableView!
    
    //MARK: Native functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        //        let toDoItem1 = ToDoItem.init(item: "Value 1", checked: true, dateTimeCreateString: "2014-05-20 22:05:54")//, colorItem: ColorMode.getColorForItemAtIndex(5)
        //        let toDoItem2 = ToDoItem.init(item: "Value 2", checked: false)
        //        //, colorItem:ColorMode.getColorForItemAtIndex(3)
        //        let toDoItem3 = ToDoItem.init(item: "Value 3", checked: true)
        //
        //        toDoItems.append(toDoItem1)
        //        toDoItems.append(toDoItem2)
        //        toDoItems.append(toDoItem3)
        
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
        let toDoItem1 = ToDoItem.init(item: "Value 1", checked: true, dateTimeCreateString: "2014-05-20 22:05:54")//, colorItem: ColorMode.getColorForItemAtIndex(5)
        let toDoItem2 = ToDoItem.init(item: "Value 2", checked: false)
        //, colorItem:ColorMode.getColorForItemAtIndex(3)
        let toDoItem3 = ToDoItem.init(item: "Value 3", checked: true)
        
        toDoItems.append(toDoItem1)
        toDoItems.append(toDoItem2)
        toDoItems.append(toDoItem3)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController!.navigationBar.barTintColor = UIColor.whiteColor()//
        self.navigationController?.navigationBar.alpha = 1
        
        toDoListTableView.toDoItems = toDoItems
        toDoListTableView.reloadData()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetailViewController" {
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.detailDelegate = self
            
            // set a variable in the second view controller with the String to pass
            //detailViewController.receivedString = recivedFromMainListValue
            detailViewController.receivedCell = recivedFromMainListValueCell//! as ToDoItem
            
            
        }
    }
    
    
    // MARK: DataEnteredDelegate functions
    func userDidEnterInformation(info: String) {
        //        let item3_testSearch: ToDoItem = ToDoItem(item: info, checked: true)
        //        let ddddd = toDoItems.indexOf{$0 === item3_testSearch}
        
        let filteredItems = toDoItems.filter({(itemElement : ToDoItem) -> Bool in
            //return itemElement.item.lowercaseString.containsString(recivedFromMainListValue.lowercaseString)
            
            return itemElement.item.lowercaseString.containsString(getTitleValueFromMainListValueCell ().lowercaseString)
        })//info.lowercaseString
        
        if filteredItems.count == 1 {
            //toDoItems
            filteredItems [0].item = info
            ereseuserEnterInformation ()
        }else{
            toDoItems.append(ToDoItem.init(item: info, checked: false))
        }
        
        
        saveData()
    }
    
    func getTitleValueFromMainListValueCell () -> String {
        //return recivedFromMainListValueCell =
        //return ""
        //return String(recivedFromMainListValueCell?.item)
        
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
    
    //    //MARK: delegate Button Click
    //    func didTouchMoreButtonForController(item toDoItem: ToDoItem?, itemLabel: UILabel) {
    //        if (toDoItem != nil) {
    //            let myActionSheet = ActionSheetCellControl().ButtonActionSheetCellItems(toDoItem, itLabel: itemLabel) as! ActionSheetCellControl
    //            myActionSheet.delegateToReloadDataInTableViewDid = self
    //            self.presentViewController(myActionSheet, animated: true, completion: nil)
    //        }
    //    }
    
    func didTouchMoreButtonForController(item toDoItem: ToDoItem?, itemLabel: UILabel) {
        if (toDoItem != nil) {
            let toDoItemActionSheet = ToDoItemActionSheetControl(title: toDoItem?.item, message: "", preferredStyle:.ActionSheet)
            toDoItemActionSheet.toDoItem = toDoItem ?? ToDoItem.init(item: "", checked: false)
            toDoItemActionSheet.delegate = self;
            self.presentViewController(toDoItemActionSheet, animated: true, completion: nil)
        }
    }
    
    func didChangeAction() {
        toDoListTableView.reloadData()
    }
    
    @IBAction func editButtonTouched(sender: AnyObject) {
        toDoListTableView.setEditing(toDoListTableView.editing ? false : true, animated: true)
        //toDoListTableView.Mov
        
        saveData()
        
    }
    
    //MARK: SAVE DATA NSUserDefaults
    func saveData () {
        //save data
        let toDoItemData = NSKeyedArchiver.archivedDataWithRootObject(toDoItems)
        
        NSUserDefaults.standardUserDefaults().setObject(toDoItemData, forKey: "toDoItemData")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    //MARK: ReloadDataInTableView from ActionSheetCellControls
    
    //    func ReloadDataInTableViewDidInn () {
    //        toDoListTableView.reloadData()
    //    }
    
    //    func ReloadDataInTableViewDid () {
    //        delegateToReloadDataInTableViewDidInn?.ReloadDataInTableViewDidInn()
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

