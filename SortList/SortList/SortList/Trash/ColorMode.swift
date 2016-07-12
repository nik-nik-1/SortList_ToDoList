//
//  ColorMode.swift
//  SortList
//
//  Created by mc373 on 15.02.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class ColorMode: UIColor {

	//let massColorsIn = ColorMode.getUsesColorForItems()


	var massColors: [UIColor] = [] // 9 pieces


	override init () {
		super.init()
		self.massColors          = getUsesColorForItems()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	required convenience init(colorLiteralRed red: Float, green: Float, blue: Float, alpha: Float) {
		fatalError("init(colorLiteralRed:green:blue:alpha:) has not been implemented")
	}

	func getDefaultColorForItem() -> UIColor {

		let defaultColorForReturn: UIColor

		defaultColorForReturn = massColors[0]//getUsesColorForItems()[0]

		return defaultColorForReturn
	}


	func getUsesColorForItems() -> [UIColor] {
		//UIColor(red: 0, green: 0, blue: 0, alpha: 0)
		// 9 pieces

		massColors.insert(UIColor.whiteColor(), atIndex: 0)//[0] = default color
		massColors.append(UIColor(red: 1.0, green: 0.3006, blue: 0.2565, alpha: 1.0)) //red
		massColors.append(UIColor(red: 1.0, green: 0.6679, blue: 0.4737, alpha: 1.0)) //yellow + brown
		massColors.append(UIColor(red: 1.0, green: 0.6632, blue: 0.0, alpha: 1.0)) //yellow
		massColors.append(UIColor(red: 0.837, green: 0.8262, blue: 0.2558, alpha: 1.0)) //green
		massColors.append(UIColor(red: 0.6584, green: 0.8222, blue: 0.0, alpha: 1.0)) //light green
		massColors.append(UIColor(red: 0.462, green: 0.8383, blue: 1.0, alpha: 1.0)) //sky blue
		massColors.append(UIColor(red: 0.4763, green: 0.4931, blue: 0.8383, alpha: 1.0)) //magenta
		massColors.append(UIColor(red: 1.0, green: 0.8469, blue: 1.0, alpha: 1.0)) //light magenta

		return massColors
	}

	func getColorForItemAtIndex(inx: Int? = 0 ) -> UIColor {

		let massColorsIn = massColors//getUsesColorForItems()
		if inx > massColorsIn.count {
			return   getDefaultColorForItem()
		}

		return massColorsIn [inx!]
	}
}
