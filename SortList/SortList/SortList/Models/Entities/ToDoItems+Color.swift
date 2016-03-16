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
    
    static func getDefaultColorFortem() -> UIColor{
        
        var colorForReturn = UIColor.whiteColor()
        
        let colorPickerItem = ColorPickerViewController.init()
        if colorPickerItem.colorList.count > 0 {
            let stringColor = colorPickerItem.colorList[0]
            
            colorForReturn =  colorPickerItem.externalConvertHexToUIColor(hexColor: stringColor)
        }
        
        return colorForReturn
    }
    
}