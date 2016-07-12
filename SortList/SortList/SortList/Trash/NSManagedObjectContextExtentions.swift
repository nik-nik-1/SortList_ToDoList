//
//  NsManagerExtentions.swift
//  SortList
//
//  Created by mc373 on 23.03.16.
//  Copyright © 2016 Local. All rights reserved.
//

//NOT USED !!!

import CoreData
import ObjectiveC


extension NSManagedObjectContext {
	//let usedURLForResource:String = ""
	private struct AssociatedKeys {
		static var usedURLForResource = ""
	}

	var usedURLForResource: String? {
		get {
			return objc_getAssociatedObject(self, &AssociatedKeys.usedURLForResource) as? String
		}
		set {
			if let newValue = newValue {
				objc_setAssociatedObject(
					self,
					&AssociatedKeys.usedURLForResource,
					newValue as NSString?,
					objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC                )
			}
		}
	}
}
