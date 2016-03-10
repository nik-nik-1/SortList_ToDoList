//
//  ViewController.swift
//  SortList
//
//  Created by Vitaly on 2/1/16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UIViewController, ToDoListTableViewDelegate, DataEnteredDelegate,ToDoItemActionSheetControlDelegate {
    
    var toDoItems: [ToDoItem] = [] {
        didSet{
            
            
        }
    }
    //var toDoItems: [NSManagedObject] = []
    
    var managedObjectContext: NSManagedObjectContext? = nil
    
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
    
    //MARK: SAVE CoreData
    func insertNewObject(sender: AnyObject) {
        let context = self.fetchedResultsController.managedObjectContext
        let entity = self.fetchedResultsController.fetchRequest.entity!
        let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context)
        
        // If appropriate, configure the new managed object.
        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
        newManagedObject.setValue(NSDate(), forKey: "dateTimeCreate")
        
        // Save the context.
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //print("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        //let object = self.fetchedResultsController.objectAtIndexPath(indexPath)
        //cell.textLabel!.text = object.valueForKey("timeStamp")!.description
    }
    
    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("CoreToDoItems", inManagedObjectContext: self.managedObjectContext!)
        fetchRequest.entity = entity
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "item", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
   //     aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            //print("Unresolved error \(error), \(error.userInfo)")
            abort()
        }
        
        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController? = nil
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.toDoListTableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Insert:
            self.toDoListTableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Delete:
            self.toDoListTableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        default:
            return
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            toDoListTableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            toDoListTableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            self.configureCell(toDoListTableView.cellForRowAtIndexPath(indexPath!)!, atIndexPath: indexPath!)
        case .Move:
            toDoListTableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            toDoListTableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.toDoListTableView.endUpdates()
    }
    
}

