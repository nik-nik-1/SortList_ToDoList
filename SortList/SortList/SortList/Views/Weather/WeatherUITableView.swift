//
//  WeatherUITableView.swift
//  SortList
//
//  Created by mc373 on 23.03.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class WeatherUITableView: UITableView, UITableViewDataSource, UITableViewDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    let arreyOfCellTemp:[String] = ["first","second","third","fourth"]
    
    var weatherItems: [WeatherItem] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
//        self.registerClass(WeatherItemsTableViewCell.self, forCellReuseIdentifier: "WeatherCell")
        
        self.dataSource = self
        self.delegate = self
        
    }

        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arreyOfCellTemp.count//weatherItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell  {
//       let cell = self.dequeueReusableCellWithIdentifier("WeatherCell") as! WeatherItemsTableViewCell
//       return cell

        let cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell") as? WeatherItemsTableViewCell
        
//        if (cell == nil) {
//            // Load the nib and assign an owner
//            let topLevelObjects = NSBundle.mainBundle().loadNibNamed("WeatherItemsTableViewCell", owner: self, options: nil);
//            cell = topLevelObjects.first as? WeatherItemsTableViewCell
//        }
        
        //TEST !! : 
//        cell?.weatherNameLabelTableItem?.text = arreyOfCellTemp[indexPath.row]
        //cell!.textLabel?.text = arreyOfCellTemp[indexPath.row]
        
        cell?.weatherNameLabelTableItem?.text = arreyOfCellTemp[indexPath.row]
        cell?.weatherValueLabelTableItem?.text = "\(arreyOfCellTemp[indexPath.row]) ddddd"
        
        //////cell?.delegate = self
        return cell!
    }
    
    // MARK: UITableView delegate
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
//        let weatherItemCell = cell as! WeatherItemsTableViewCell
//        let weatherItem = weatherItems[indexPath.row]
//        
//        weatherItemCell.weatherItem = weatherItem
        
    }
    
}
