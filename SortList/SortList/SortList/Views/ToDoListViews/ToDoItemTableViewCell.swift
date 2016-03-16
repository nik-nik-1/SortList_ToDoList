//
//  ToDoItemTableViewCell.swift
//  SortList
//
//  Created by Vitaly on 2/1/16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

protocol ToDoItemTableViewCellDelegate {
    func didTouchMoreButton(cell: UITableViewCell?)
    //func chaingeTextNarrovIfCheckedOrNot (needCheck: Bool, itemLabel:UILabel)
}

//protocol ToDoItemforListControllerDelegate {
//    func chaingeTextNarrovIfCheckedOrNot (needCheck: Bool, itemLabel:UILabel) -> Bool
//}


class ToDoItemTableViewCell: UITableViewCell
    //, buttonActiveActionSheetCellItems
{
    
    @IBOutlet weak var dateViewTableCell: UILabel!
    @IBOutlet weak var selectItemSwitchView: UISwitch!
    @IBOutlet weak var itemLabelView: UILabel!
    
    var delegate: ToDoItemTableViewCellDelegate?
    //    var delegateListController: ToDoItemforListControllerDelegate?
    
    //@IBOutlet weak var ButtonActionSheetCell: UIButton!
    @IBAction func ButtonActionSheetCellTappet(sender: AnyObject) {
        delegate?.didTouchMoreButton(self)
    }
    
    var toDoItem: ToDoItem! {
        didSet {
            selectItemSwitchView?.setOn(toDoItem.checked, animated: false)
            itemLabelView?.text     = toDoItem.item
            dateViewTableCell?.text = NSDate.parseForMainTableView(toDoItem.dateTimeCreate!)
            changeTextNarrovIfCheckedOrNot()
        }
    }

    
    
    //MARK: init cell
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    func setupViews() {
        contentView.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.1) // light green
        //        if itemLabelView != nil {
        //            ActionSheetCellControl().chaingeTextNarrovIfCheckedOrNotRedirect (true, itemLabel: itemLabelView)
        //        }
    }
    
    @IBAction func toDoItemUpdateValueChanged() {
        //        toDoItem.checked = selectItemSwitchView.on
        changeTextNarrovIfCheckedOrNot()
        
    }
    
    func changeTextNarrovIfCheckedOrNot() {
        let attributedString = NSMutableAttributedString(string: toDoItem.item!)
        
        var firstAttributes: NSDictionary
        if toDoItem.checked as Bool {
            firstAttributes = [NSForegroundColorAttributeName: UIColor.lightGrayColor(), NSStrikethroughStyleAttributeName: 1]
        } else {
            firstAttributes = [NSForegroundColorAttributeName: itemLabelView.tintColor, NSStrikethroughStyleAttributeName: 0]
        }
        
        let itemString = NSString(string: toDoItem.item!)
        
        attributedString.addAttributes(firstAttributes as! [String : AnyObject], range: itemString.rangeOfString(toDoItem.item!))
        itemLabelView.attributedText = attributedString
    }

    
}
