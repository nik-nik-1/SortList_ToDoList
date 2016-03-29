//
//  GenerapPurposeExtensions.swift
//  SortList
//
//  Created by mc373 on 29.03.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

//helps to replace cymbol in String
extension String
{
    func replace(target: String, withString: String) -> String
    {
        return self.stringByReplacingOccurrencesOfString(target, withString: withString, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
}
