//
//  ToDoCollectionView.swift
//  SortList
//
//  Created by mc373 on 07.04.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

protocol ToDoListCollectionViewDelegate {
    func didTouchMoreButtonForController(item toDoItem: ToDoItem?, itemLabel: UILabel)
    func setCurentItemTextLabel (item: ToDoItem)
}

class ToDoCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate,ToDoItemCollectionViewCellDelegate{

    var toDoItems: [ToDoItem] = [] {
        didSet {
            self.reloadData()
        }
    }
    var toDoListDelegate: ToDoListCollectionViewDelegate?
    var updateListWithAnimation:Bool = true
    
    //var toDoListDelegate: ToDoListTableViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
//        self.registerClass(ToDoItemCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        let nib = UINib(nibName: "ToDoItemCollectionViewCell", bundle: nil)
        
        self.registerNib(nib, forCellWithReuseIdentifier: "CollectionCell")
//        self.backgroundColor = UIColor.brownColor() //TEST !!!!

        
        self.dataSource = self
        self.delegate = self
    }

    
    //MARK: UICollectionViewDataSource func
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return toDoItems.count
    }
   
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        
        
        let cell = self.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath) as? ToDoItemCollectionViewCell
        
//        if (cell == nil) {
//            // Load the nib and assign an owner
//            let topLevelObjects = NSBundle.mainBundle().loadNibNamed("cell", owner: self, options: nil);
//            cell = topLevelObjects.first as? ToDoItemCollectionViewCell
//        }
        
        cell?.delegate = self
        
        return cell!
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        let toDoItemCell = cell as! ToDoItemCollectionViewCell
        let toDoItem = toDoItems[indexPath.row]
        
        toDoItemCell.toDoItemElem = toDoItem
        
        if updateListWithAnimation {
            //CellAnimator.animateCell(cell, withTransform: CellAnimator.TransformWave, andDuration: 1)
            CellAnimator.animateCell(cell)
            
//            //Disable animation
//            if indexPath.row == toDoItems.count-1 {
//                updateListWithAnimation = false
//            }
        }

    }
    
    //MARK: ToDoItemCollectionViewCellDelegate functions
    func didTouchMoreButton(cell: UICollectionViewCell?) {
        if (cell != nil) {
            let toDoItem       = (cell as! ToDoItemCollectionViewCell).toDoItemElem
            let itemLabelView  = (cell as! ToDoItemCollectionViewCell).itemLabelView as UILabel
            
            toDoListDelegate?.didTouchMoreButtonForController(item: toDoItem, itemLabel: itemLabelView)
        }
    }
}
