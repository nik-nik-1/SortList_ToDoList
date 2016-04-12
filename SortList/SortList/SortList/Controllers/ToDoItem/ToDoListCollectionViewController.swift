//
//  ToDoListCollectionViewController.swift
//  SortList
//
//  Created by mc373 on 11.04.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class ToDoListCollectionViewController: UIViewController, ToDoListCollectionViewDelegate, ToDoItemActionSheetControlDelegate, DataEnteredDelegate{
    
    let listFlowLayout = ProductsListFlowLayout()
    let gridFlowLayout = ProductsGridFlowLayout()
    
    private var longPressGesture: UILongPressGestureRecognizer!
    private var tapPressGesture: UITapGestureRecognizer!
    var toDoItems: [ToDoItem] = [] {
        didSet {
            toDoCollectionView.toDoItems = toDoItems
            toDoCollectionView.reloadData()
            
            enableDisableEditButton()
        }
    }
    
    var recivedFromMainListValueCell: ToDoItem? = nil {
        //First set default color for lastUsed Cell
        willSet {
            //print("Old value is \(recivedFromMainListValueCell?.item), new value is \(newValue?.item)")
            pickOutWorkedCell(recivedFromMainListValueCell)
        }
        //Done set new color for curent Cell
        didSet{
            pickOutWorkedCell(recivedFromMainListValueCell, borderWidth: 2.0, borderColor: UIColor.grayColor())
        }
    }
    
    @IBOutlet weak var editButtonPanell: UIBarButtonItem!
    @IBOutlet weak var toDoCollectionView: ToDoCollectionView!
    @IBOutlet weak var gridButton: UIBarButtonItem!
    @IBOutlet weak var listButton: UIBarButtonItem!
    
    @IBAction func listButtonPressed(sender: AnyObject) {
        changeLayoutInCollection (self.listFlowLayout)
    }
    @IBAction func gridButtonPressed(sender: AnyObject) {
        changeLayoutInCollection (self.gridFlowLayout)
    }
    
    @IBAction func editButtonTouched(sender: AnyObject) {
        setPossibilityOfEditingMode()
    }
    
    func changeLayoutInCollection (collectionLayuotToChanga: UICollectionViewLayout) {
        pickOffAllCell()
        toDoCollectionView.cellIstanceName = collectionLayuotToChanga.iDOfInstanse!
        toDoCollectionView.updateListWithAnimation = true
        toDoCollectionView.reloadData()
        
        UIView.animateWithDuration(0.5) { () -> Void in
            self.toDoCollectionView.collectionViewLayout.invalidateLayout()
            self.toDoCollectionView.setCollectionViewLayout(collectionLayuotToChanga, animated: false)
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
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(ToDoListCollectionViewController.handleLongGesture(_:)))
        self.toDoCollectionView.addGestureRecognizer(longPressGesture)
        
        tapPressGesture = UITapGestureRecognizer(target: self, action: #selector(ToDoListCollectionViewController.handleTapGesture(_:)))
        tapPressGesture.cancelsTouchesInView = false;
        self.toDoCollectionView.addGestureRecognizer(tapPressGesture)
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
    func setCurentItemTextLabel (item: ToDoItem, callBack: ((Bool) -> Void)?){
        recivedFromMainListValueCell = item
        
        callBack!(recivedFromMainListValueCell != nil)
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
}


//MARK: Helpers
extension ToDoListCollectionViewController{
    
    //Painted working cell
    func pickOutWorkedCell (recivedFromMainListValueCell:ToDoItem?, borderWidth:CGFloat = 0.0, borderColor:UIColor = UIColor.blackColor()) {
        if let recivedCell:ToDoItem = recivedFromMainListValueCell { // not nil
            let cell = self.toDoCollectionView.cellForItemAtIndexPath(recivedCell.indexpathOfCell!) as! ToDoItemCollectionViewCell
            
            setParametretoCell(cell,borderWidth:borderWidth,borderColor:borderColor)
        }
    }
    
    func pickOffAllCell () {
        for item in self.toDoCollectionView.visibleCells() as! [ToDoItemCollectionViewCell]  {
            
            let indexpath : NSIndexPath = self.toDoCollectionView.indexPathForCell(item as ToDoItemCollectionViewCell)!
            let cell = self.toDoCollectionView.cellForItemAtIndexPath(indexpath) as! ToDoItemCollectionViewCell
            
            setParametretoCell(cell,borderWidth:0.0, borderColor:UIColor.blackColor())
        }
    }
    
    func setParametretoCell(cell:ToDoItemCollectionViewCell,borderWidth:CGFloat,borderColor:UIColor) {
        cell.layer.borderWidth = borderWidth
        cell.layer.borderColor = borderColor.CGColor
    }
    
    //Edit button pressed
    func setPossibilityOfEditingMode () {
        
        if(editButtonPanell.title == "Edit"){
            
            editButtonPanell.title = "Done"
            
            for item in self.toDoCollectionView.visibleCells() as! [ToDoItemCollectionViewCell]  {
                
                let indexpath : NSIndexPath = self.toDoCollectionView.indexPathForCell(item as ToDoItemCollectionViewCell)!
                let cell = self.toDoCollectionView.cellForItemAtIndexPath(indexpath) as! ToDoItemCollectionViewCell
                
                //Close Button
                let closeButton: UIButton = cell.viewWithTag(102) as! UIButton
                closeButton.hidden = false
            }
        } else {
            editButtonPanell.title = "Edit"
            self.toDoCollectionView.reloadData()
        }
        
    }
    
    //ToDoListCollectionViewDelegate
    func getInfoNeedHideCloseButton () -> Bool{
        var valueToReturn:Bool = true
        
        if  editButtonPanell.title == "Edit" {
            valueToReturn = true
        } else {
            valueToReturn = false
        }
        return valueToReturn
    }
    
    // disable edit button if no record
    private func enableDisableEditButton() {
        if toDoItems.count == 0 {
            editButtonPanell.enabled = false
        }else{
            editButtonPanell.enabled = true
        }
    }
    
    //Gesture
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case UIGestureRecognizerState.Began:
            guard let selectedIndexPath = self.toDoCollectionView.indexPathForItemAtPoint(gesture.locationInView(self.toDoCollectionView)) else {
                break
            }
            if #available(iOS 9.0, *) {
                toDoCollectionView.beginInteractiveMovementForItemAtIndexPath(selectedIndexPath)
            } else {
                // Fallback on earlier versions
            }
        case UIGestureRecognizerState.Changed:
            if #available(iOS 9.0, *) {
                toDoCollectionView.updateInteractiveMovementTargetPosition(gesture.locationInView(gesture.view!))
            } else {
                // Fallback on earlier versions
            }
        case UIGestureRecognizerState.Ended:
            if #available(iOS 9.0, *) {
                toDoCollectionView.endInteractiveMovement()
            } else {
                // Fallback on earlier versions
            }
        default:
            if #available(iOS 9.0, *) {
                toDoCollectionView.cancelInteractiveMovement()
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    //Gesture
    func handleTapGesture(gesture: UITapGestureRecognizer) {
        
        switch(gesture.state) {
        case UIGestureRecognizerState.Ended:
            guard let selectedIndexPath = self.toDoCollectionView.indexPathForItemAtPoint(gesture.locationInView(self.toDoCollectionView)) else {
                break
            }
        case UIGestureRecognizerState.Began: break
        default: break
            
        }
    }
    
}
