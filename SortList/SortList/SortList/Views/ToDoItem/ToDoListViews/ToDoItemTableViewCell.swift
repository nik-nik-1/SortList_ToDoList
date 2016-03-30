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
}


class ToDoItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateViewTableCell: UILabel!
    @IBOutlet weak var selectItemSwitchView: UISwitch!
    @IBOutlet weak var itemLabelView: UILabel!
    
    @IBAction func ButtonActionSheetCellTappet(sender: AnyObject) {
        delegate?.didTouchMoreButton(self)
    }
    @IBAction func toDoItemUpdateValueChanged() {
        
        toDoItemElem.setValue(selectItemSwitchView.on, forKey: "checked")
        CoreDataUtil.saveContext(ToDoItem.getEntityNameOfObject())
        
        changeTextNarrovIfCheckedOrNot()
    }
    
    
    var delegate: ToDoItemTableViewCellDelegate?
    var toDoItemElem: ToDoItem! {
        didSet {
            selectItemSwitchView?.setOn(toDoItemElem.checked, animated: false)
            itemLabelView?.text     = toDoItemElem.item
            dateViewTableCell?.text = NSDate.parseForMainTableView(toDoItemElem.dateTimeCreate!)
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
    }
    
    func changeTextNarrovIfCheckedOrNot() {
        let attributedString = NSMutableAttributedString(string: toDoItemElem.item!)
        
        var firstAttributes: NSDictionary
        if toDoItemElem.checked as Bool {
            firstAttributes = [NSForegroundColorAttributeName: UIColor.lightGrayColor(), NSStrikethroughStyleAttributeName: 1]
        } else {
            firstAttributes = [NSForegroundColorAttributeName: itemLabelView.tintColor, NSStrikethroughStyleAttributeName: 0]
        }
        
        let itemString = NSString(string: toDoItemElem.item!)
        
        attributedString.addAttributes(firstAttributes as! [String : AnyObject], range: itemString.rangeOfString(toDoItemElem.item!))
        itemLabelView.attributedText = attributedString
    }
}
