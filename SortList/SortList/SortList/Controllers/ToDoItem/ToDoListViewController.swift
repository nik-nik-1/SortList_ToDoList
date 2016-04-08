//
//  ViewController.swift
//  SortList
//
//  Created by Vitaly on 2/1/16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController, ToDoListTableViewDelegate, ToDoListCollectionViewDelegate, ToDoItemActionSheetControlDelegate, DataEnteredDelegate{
    
    var toDoItems: [ToDoItem] = [] {
        didSet {
            //REMOVE!!
            toDoListTableView.toDoItems = toDoItems
            toDoListTableView.reloadData()

            toDoCollectionView.toDoItems = toDoItems
            toDoCollectionView.reloadData()
            //
            //            toggleTableEditingMode()
            enableDisableEditButton()
        }
    }
    var recivedFromMainListValueCell: ToDoItem? = nil
    
    @IBOutlet weak var editButtonPanell: UIBarButtonItem!
    @IBAction func editButtonTouched(sender: AnyObject) {
        toggleTableEditingMode()
    }
    
    @IBOutlet weak var toDoListTableView: ToDoListTableView!
    @IBOutlet weak var toDoCollectionView: ToDoCollectionView!
    
    var isGridFlowLayoutUsed:Bool = false
    let listFlowLayout = ProductsListFlowLayout()
    let gridFlowLayout = ProductsGridFlowLayout()
    
//    required init?(coder aDecoder: NSCoder) {
//        self.isGridFlowLayoutUsed = false
//        super.init(coder: aDecoder)
//    }
    
    @IBOutlet weak var gridButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    @IBAction func listButtonPressed(sender: AnyObject) {
        // change to list layout
        isGridFlowLayoutUsed = false
        
        UIView.animateWithDuration(0.2) { () -> Void in
            self.toDoCollectionView.collectionViewLayout.invalidateLayout()
            self.toDoCollectionView.setCollectionViewLayout(self.listFlowLayout, animated: true)
        }
    }
    @IBAction func gridButtonPressed(sender: AnyObject) {
        // change to grid layout
        isGridFlowLayoutUsed = true
        
        UIView.animateWithDuration(0.2) { () -> Void in
            self.toDoCollectionView.collectionViewLayout.invalidateLayout()
            self.toDoCollectionView.setCollectionViewLayout(self.gridFlowLayout, animated: true)
        }
    }
    
    
    func setupDatasource() {
//        itemsToDisplay = [ImageToDisplay(imageName: "1"), ImageToDisplay(imageName: "2"), ImageToDisplay(imageName: "3"), ImageToDisplay(imageName: "4"),
//                          ImageToDisplay(imageName: "5"), ImageToDisplay(imageName: "6"), ImageToDisplay(imageName: "7"), ImageToDisplay(imageName: "8"),
//                          ImageToDisplay(imageName: "9"), ImageToDisplay(imageName: "10")]
        
        toDoCollectionView.reloadData()
    }
    
    func setupInitialLayout() {
        isGridFlowLayoutUsed = true
        toDoCollectionView.collectionViewLayout = gridFlowLayout
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        toDoCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    //    @IBAction func buttonGoBackToMenuList(sender: AnyObject) {
    //        self.navigationController?.popViewControllerAnimated(true)
    //    }

//    var switchView = true
//    @IBAction func ChangeViewInToDoList(sender: AnyObject) {
//        var fromView: UIView
//        var toView: UIView
//        
//        if switchView//(self.toDoListTableView.superview == self.view)
//        {
//            fromView = self.toDoListTableView;
//            toView = self.toDoCollectionView;
//        }
//        else
//        {
//            fromView = self.toDoCollectionView;
//            toView = self.toDoListTableView;
//        }
//        
//        toView.frame = self.view.bounds;
//        
//        UIView.transitionFromView(fromView, toView: toView, duration: 0.25, options: [.TransitionCrossDissolve, .ShowHideTransitionViews], completion: nil)
//        //        fromView.removeFromSuperview()
//        //        self.view.addSubview(toView)
//        
//        if toView == self.toDoListTableView {
//            
//            let itemView = (toView as! ToDoListTableView)
//            itemView.updateListWithAnimation = true
//            itemView.reloadData()
//            
//        } else if toView == self.toDoCollectionView{
//            (toView as! UICollectionView).reloadData()
//        } else {
//            //??
//        }
//        
//        
//        switchView = !switchView
//    }
    
    //MARK: Native functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        if let loadedtoDoItemData = NSUserDefaults.standardUserDefaults().objectForKey("toDoItemData") as? NSData {
        //            if let toDoItemArray = NSKeyedUnarchiver.unarchiveObjectWithData(loadedtoDoItemData) as? [ToDoItem] {
        //                for itemS in toDoItemArray {
        //                    toDoItems.append(itemS)
        //                }
        //            } else {
        //                setDefaultData ()
        //            }
        //        } else {
        //            setDefaultData ()
        //        }
        toDoListTableView.toDoListDelegate = self;
        
//        self.toDoListTableView.frame = self.view.bounds
//        self.view.addSubview(self.toDoListTableView)
        
        setupInitialLayout()
    }
    
    //    func setDefaultData () {
    //
    //    }
    
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
        toDoListTableView.reloadData()
    }
    
    
    
    // toggle table editing mode
    private func toggleTableEditingMode() {
        let tBool: Bool = toDoListTableView.editing
        if tBool {
            editButtonPanell.title = "Edit"
            
        }else{
            editButtonPanell.title = "Done"
        }
        toDoListTableView.setEditing(tBool ? false : true, animated: true)
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

