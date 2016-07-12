//
//  PlistUtil.swift
//  SortList
//
//  Created by mc373 on 30.03.16.
//  Copyright © 2016 Local. All rights reserved.
//
import UIKit

class PlistUtil {


	//MARK: Get saved value from Plist
	static func getSavedStringValue (nameOfItem itemName: String,
	                                            pListName plistName: String,
	                                                      needToSaveBetweenSessions: Bool = true) -> String {
		// swiftlint:disable:previous line_length
		var valuetoReturn: String = ""

		if let tempValuetoReturn = getSavedValue (itemName,
		                                          plistName: plistName,
		                                          needToSaveBetweenSessions: needToSaveBetweenSessions) {

			valuetoReturn = (tempValuetoReturn as? String)!
		}

		return valuetoReturn
	}

	static private func getSavedIntValue (itemName: String,
	                                      plistName: String,
	                                      needToSaveBetweenSessions: Bool = true) -> Int {
		var valuetoReturn: Int = 0

		if let tempValuetoReturn = getSavedValue (itemName,
		                                          plistName: plistName,
		                                          needToSaveBetweenSessions: needToSaveBetweenSessions) {

			valuetoReturn = (tempValuetoReturn as? Int)!
		}

		return valuetoReturn
	}

	static private func getSavedValue (itemName: String,
	                                   plistName: String,
	                                   needToSaveBetweenSessions: Bool) -> AnyObject? {
		var valuetoReturn: AnyObject?

		do {
			if let itemValueFromPlist: NSString = try plistGet(itemName,
			                                                   forPlistNamed: plistName,
			                                                   needToSaveBetweenSessions: needToSaveBetweenSessions) as? NSString {
				// swiftlint:disable:previous line_length


				valuetoReturn = itemValueFromPlist
			}
		} catch {
			valuetoReturn = nil
		}
		return valuetoReturn
	}

	//MARK: Save value in Plist
	static func saveStringValue(valueItem: String?,
	                            itemName: String,
	                            plistName: String) {
		saveValue(valueItem, itemName: itemName, plistName: plistName)
	}

	static private func saveValue(valueItem: AnyObject?,
	                              itemName: String,
	                              plistName: String) {

		do {
			if valueItem != nil {
				try plistSet(valueItem!,
				             forKey: itemName,
				             inPlistNamed: plistName,
				             needToSaveBetweenSessions: true)
			}

		} catch { }
	}

}
