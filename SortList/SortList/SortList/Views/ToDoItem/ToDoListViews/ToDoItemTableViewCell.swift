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
	@IBOutlet weak var colorPreview: UIView!


	var delegate: ToDoItemTableViewCellDelegate?
	var toDoItemElem: ToDoItem! {
		didSet {
			selectItemSwitchView?.setOn(toDoItemElem.checked, animated: false)
			itemLabelView?.text     = toDoItemElem.item
			dateViewTableCell?.text = NSDate.parseForMainTableView(toDoItemElem.dateTimeCreate!)
			changeTextNarrovIfCheckedOrNot()

			setupCellViews()
		}
	}


	//MARK: init cell
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		//        setupViews()
	}

	override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		//        setupViews()
	}

	func setupCellViews() {
		//contentView.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.1) // light green

		if toDoItemElem != nil {
			if let selectedUIColor = toDoItemElem.colorItem as? UIColor {
				// swiftlint:disable:next line_length
				let temStructOfColor = ColorPickerViewController.getRigthParametersOfColorForDrawing(selectedUIColor)
				colorPreview.backgroundColor = selectedUIColor
				contentView.backgroundColor = temStructOfColor.сolor02a

				selectItemSwitchView.onTintColor    = temStructOfColor.сolor04a
				var tColor: UIColor = temStructOfColor.сolor02a
				if selectedUIColor == UIColor.whiteColor() {
					tColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
				}
				selectItemSwitchView.tintColor      = tColor

				//                selectItemSwitchView.thumbTintColor = selectedUIColor

			}
		}

	}

	func changeTextNarrovIfCheckedOrNot() {
		TextView.changeTextNarrovIfCheckedOrNot(toDoItemElem, itemLabelView: itemLabelView)
	}
}
