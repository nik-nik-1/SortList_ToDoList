//
//  ToDoListCollectionViewController.swift
//  SortList
//
//  Created by mc373 on 11.04.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class ToDoListCollectionViewController: UIViewController, ToDoListCollectionViewDelegate, ToDoItemActionSheetControlDelegate, DataEnteredDelegate{
    
    var toDoItems: [ToDoItem] = [] {
        didSet {
            
            toDoCollectionView.toDoItems = toDoItems
            toDoCollectionView.reloadData()
            
            enableDisableEditButton()
        }
    }
    var recivedFromMainListValueCell: ToDoItem? = nil
    
    @IBOutlet weak var editButtonPanell: UIBarButtonItem!
    @IBAction func editButtonTouched(sender: AnyObject) {
        toggleTableEditingMode()
    }
    
    @IBOutlet weak var toDoCollectionView: ToDoCollectionView!
    
    let listFlowLayout = ProductsListFlowLayout()
    let gridFlowLayout = ProductsGridFlowLayout()
    
    @IBOutlet weak var gridButton: UIBarButtonItem!
    @IBOutlet weak var listButton: UIBarButtonItem!
    @IBAction func listButtonPressed(sender: AnyObject) {
        changeLayoutInCollection (self.listFlowLayout)
    }
    @IBAction func gridButtonPressed(sender: AnyObject) {
        
        changeLayoutInCollection (self.gridFlowLayout)
    }
    
    func changeLayoutInCollection (collectionLayuotToChanga: UICollectionViewLayout) {
        toDoCollectionView.cellIstanceName = collectionLayuotToChanga.iDOfInstanse!
        toDoCollectionView.updateListWithAnimation = true
        toDoCollectionView.reloadData()
        
        UIView.animateWithDuration(0.2) { () -> Void in
            self.toDoCollectionView.collectionViewLayout.invalidateLayout()
            self.toDoCollectionView.setCollectionViewLayout(collectionLayuotToChanga, animated: true)
            self.toDoCollectionView.updateListWithAnimation = false
        }
    }
    
    func setupInitialLayout() {
        toDoCollectionView.cellIstanceName = gridFlowLayout.iDOfInstanse!
        toDoCollectionView.collectionViewLayout = gridFlowLayout
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        toDoCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    //MARK: Native functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoCollectionView.toDoListDelegate = self;
        setupInitialLayout()
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
        toDoCollectionView.reloadData()
    }
    
    
    // toggle table editing mode
    private func toggleTableEditingMode() {
        //        let tBool: Bool = toDoListTableView.editing
        //        if tBool {
        //            editButtonPanell.title = "Edit"
        //
        //        }else{
        //            editButtonPanell.title = "Done"
        //        }
        //        toDoListTableView.setEditing(tBool ? false : true, animated: true)
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
