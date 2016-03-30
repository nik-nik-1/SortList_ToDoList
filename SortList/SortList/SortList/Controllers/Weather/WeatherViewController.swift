//
//  WeatherView.swift
//  SortList
//
//  Created by mc373 on 18.03.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    private let tempItemsInKlass = GeneralPurposeParametres.tempItemsInKlass

    var weatherItems: [WeatherItem] = [] {
        didSet {
            weatherTableView.weatherItems = weatherItems
            weatherTableView.reloadData()
        }
    }
    @IBOutlet weak var weatherTableView: WeatherUITableView!
    @IBAction func buttonGoBackToMenuList(sender: AnyObject) {
        saveNameOfCity()
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func DidEndEnteredCityNameAction(sender: AnyObject) {
        saveNameOfCity()
    }
    @IBOutlet weak var userCityName: UITextField!
    @IBAction func buttonGetWeatherDataPressed(sender: AnyObject) {
        saveNameOfCity()
        
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: @selector("updateWeatherTableView"), name:"updateWeatherTableFromAnotherModule", object: nil)
        
        WeatherManager.loadDataOfWeatheFromUrlToCoreData(userCityName.text!) { (data) -> Void in
            self.pushAllDataInTableFromCoreData()
            
            dispatch_async(dispatch_get_main_queue()) {
                self.weatherTableView.reloadData()
            }
        }
//        self.weatherTableView.performSelectorOnMainThread(Selector("reloadData"), withObject: nil, waitUntilDone: true)
     }
    
    private func updateWeatherTableView(){
        
        weatherTableView.reloadData()
//        NSNotificationCenter.defaultCenter().removeObserver(self, name: "updateWeatherTableFromAnotherModule", object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadDataByDefault()
     }
    
    override func viewWillAppear(animated: Bool) {
        pushAllDataInTableFromCoreData()
    }
    
    func pushAllDataInTableFromCoreData() {
        if let items = WeatherItem.allWatherItems() {
            weatherItems = items
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Save & Load Data in Plist.-file
    private func loadDataByDefault () {
        userCityName.text = PlistUtil.getSavedStringValue(nameOfItem: tempItemsInKlass.nameTemporaryForSave,  pListName: tempItemsInKlass.nameOfPList)//getSaveNamedOfCity()
    }
    private func saveNameOfCity() {
        PlistUtil.saveStringValue(userCityName.text!, itemName: tempItemsInKlass.nameTemporaryForSave, plistName: tempItemsInKlass.nameOfPList)
    }

}
