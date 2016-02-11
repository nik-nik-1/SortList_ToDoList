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

protocol ToDoItemforListControllerDelegate {
    func chaingeTextNarrovIfCheckedOrNot (needCheck: Bool, itemLabel:UILabel) -> Bool
}


class ToDoItemTableViewCell: UITableViewCell
//, buttonActiveActionSheetCellItems
{
    
    @IBOutlet weak var selectItemSwitchView: UISwitch!
    @IBOutlet weak var itemLabelView: UILabel!
    
    var delegate: ToDoItemTableViewCellDelegate?
    var delegateListController: ToDoItemforListControllerDelegate?
    
    //@IBOutlet weak var ButtonActionSheetCell: UIButton!
    @IBAction func ButtonActionSheetCellTappet(sender: AnyObject) {
        delegate?.didTouchMoreButton(self)
      
    }
   
    
    var toDoItem: ToDoItem = ToDoItem.init(item: "", checked: false) {
        didSet {
            selectItemSwitchView?.setOn(toDoItem.checked, animated: false)
            itemLabelView?.text = toDoItem.item
        }
    }
    
//    //MARK: protocol buttonCheckActionSheetCellItems
//    func CheckButtonFromActionSheetCellItemsPressed () {
//        delegateListController?.chaingeTextNarrovIfCheckedOrNot(true, itemLabel: self.itemLabelView)
//    }
    
//    func chaingeTextNarrovIfCheckedOrNot (needCheck: Bool, itemLabel:UILabel) -> Bool {
//        //retern TRUE if all OK
//        let ValueToReturn: Bool = false
//        let itemName = itemLabel.text
//        // 1
//        let string = itemName! as NSString
//        let attributedString = NSMutableAttributedString(string: string as String)
//        
//        // 2
//        var firstAttributes = [NSForegroundColorAttributeName: itemLabel.tintColor, NSStrikethroughStyleAttributeName: 0]
//        
//        if needCheck {
//            firstAttributes = [NSForegroundColorAttributeName: UIColor.lightGrayColor(), NSStrikethroughStyleAttributeName: 1]
//        }
//        
//        // 3
//        attributedString.addAttributes(firstAttributes, range: string.rangeOfString(itemName!))
//        // 4
//        self.itemLabelView.attributedText = attributedString
//        
//        return ValueToReturn
//    }
    
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
    
}
