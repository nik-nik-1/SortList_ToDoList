//
//  ToDoItems+Color.swift
//  SortList
//
//  Created by mc373 on 15.03.16.
//  Copyright © 2016 Local. All rights reserved.
//

import Foundation
import UIKit

extension ToDoItem {

	static func getDefaultColorFortem() -> UIColor {

		var colorForReturn = UIColor.whiteColor()

		//        let colorPickerItem = ColorPickerViewController()
		//        if colorPickerItem.colorList.count > 0 {
		if let colorList: NSArray = ColorPickerViewController.getListOfUsingColor() {
			let colorListCount = colorList.count
			if colorListCount > 0 {
				let stringColor = (colorList[colorListCount-1] as? String)!

				colorForReturn =  ColorPickerViewController.convertHexToUIColor(hexColor: stringColor)
			}
		}

		return colorForReturn
	}

}
