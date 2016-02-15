//
//  ColorMode.swift
//  SortList
//
//  Created by mc373 on 15.02.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class ColorMode: NSObject {
    
    //let MassColorsIn = ColorMode.getUsesColorForItems()
    
    class func getDefaultColorForItem() -> UIColor {
        
        let defaultColorForReturn:UIColor
        
        defaultColorForReturn = getUsesColorForItems()[0]
        
        return defaultColorForReturn
    }
    
    
    class func getUsesColorForItems() -> [UIColor] {
        //UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        var MassColors: [UIColor] = [] // 9 pieces
        
        MassColors.insert(UIColor.whiteColor(), atIndex: 0)//[0] = default color
        MassColors.append(UIColor(red: 1.0, green: 0.3006, blue: 0.2565, alpha: 1.0)) //red
        MassColors.append(UIColor(red: 1.0, green: 0.6679, blue: 0.4737, alpha: 1.0)) //yellow + brown
        MassColors.append(UIColor(red: 1.0, green: 0.6632, blue: 0.0, alpha: 1.0)) //yellow
        MassColors.append(UIColor(red: 0.837, green: 0.8262, blue: 0.2558, alpha: 1.0)) //green
        MassColors.append(UIColor(red: 0.6584, green: 0.8222, blue: 0.0, alpha: 1.0)) //light green
        MassColors.append(UIColor(red: 0.462, green: 0.8383, blue: 1.0, alpha: 1.0)) //sky blue
        MassColors.append(UIColor(red: 0.4763, green: 0.4931, blue: 0.8383, alpha: 1.0)) //magenta
        MassColors.append(UIColor(red: 1.0, green: 0.8469, blue: 1.0, alpha: 1.0)) //light magenta
        
        return MassColors
    }
    
    class func getColorForItemAtIndex(inx: Int? = 0 ) -> UIColor {
        let MassColorsIn = getUsesColorForItems()
        if inx > MassColorsIn.count {
            return   getDefaultColorForItem()
        }
        
        return MassColorsIn [inx!]
    }
}

