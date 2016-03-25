//
//  WeatherItemsTableViewCell.swift
//  SortList
//
//  Created by mc373 on 24.03.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class WeatherItemsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var weatherNameLabelTableItem: UILabel!
    @IBOutlet weak var weatherValueLabelTableItem: UILabel!
    
    var weatherItem: WeatherItem! {
        didSet {
            
            weatherNameLabelTableItem?.text = weatherItem.name
            
            _ = 4
        }
    }
    
    //MARK: init cell
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }

    
}
