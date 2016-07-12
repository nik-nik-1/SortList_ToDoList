//
//  ToDoItemCollectionViewCell.swift
//  SortList
//
//  Created by mc373 on 07.04.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

protocol ToDoItemCollectionViewCellDelegate {
	func didTouchMoreButton(cell: UICollectionViewCell?)
}

class ToDoItemCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var dateViewCollectionCell: UILabel!
	@IBOutlet weak var selectItemSwitchView: UISwitch!
	@IBOutlet weak var itemLabelView: UILabel!
	@IBOutlet weak var closeImage: UIButton!

	@IBAction func ButtonActionSheetCellTappet(sender: AnyObject) {
		delegate?.didTouchMoreButton(self)
	}

	@IBAction func toDoItemUpdateValueChanged(sender: AnyObject) {
		toDoItemElem.setValue(selectItemSwitchView.on, forKey: "checked")
		CoreDataUtil.saveContext(ToDoItem.getEntityNameOfObject())

		changeTextNarrovIfCheckedOrNot()
	}

	@IBOutlet weak var colorPreview: UIView!

	var delegate: ToDoItemCollectionViewCellDelegate?
	var toDoItemElem: ToDoItem! {
		didSet {
			selectItemSwitchView?.setOn(toDoItemElem.checked, animated: false)
			itemLabelView?.text     = toDoItemElem.item
			dateViewCollectionCell?.text = NSDate.parseForMainTableView(toDoItemElem.dateTimeCreate!)
			changeTextNarrovIfCheckedOrNot()

			setupCellViews()
		}
	}

	func setupCellViews() {

		if toDoItemElem != nil {
			if let selectedUIColor = toDoItemElem.colorItem as? UIColor {
				// swiftlint:disable:next line_length
				let temStructOfColor = ColorPickerViewController.getRigthParametersOfColorForDrawing(selectedUIColor)
				colorPreview.backgroundColor = selectedUIColor
				contentView.backgroundColor = temStructOfColor.сolor02a

				selectItemSwitchView.onTintColor    = temStructOfColor.сolor04a
				selectItemSwitchView.tintColor      = temStructOfColor.сolor02a
				//selectItemSwitchView.thumbTintColor = selectedUIColor

			}
		}
	}

	func changeTextNarrovIfCheckedOrNot() {
		TextView.changeTextNarrovIfCheckedOrNot(toDoItemElem, itemLabelView: itemLabelView)
	}

}
