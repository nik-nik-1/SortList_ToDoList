//
//  WeatherView.swift
//  SortList
//
//  Created by mc373 on 18.03.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
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
        //HttpRequestWork.getHttpConnectAndparseJSONforWeather(userCityName.text!)
        HttpRequestWork.loadDataOfWeatheFromUrlToCoreData(userCityName.text!)
    }
    private let tempItemsInKlass = WeatherStructInfo()
    private struct WeatherStructInfo {
        let nameTemporaryForSave: String = "nameOfWeatherCity"
        let nameOfPList: String = "mainPList"
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadDataByDefault()
        
        //weatherTableView.weatherListDelegate = self;
    }
    
    override func viewWillAppear(animated: Bool) {
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
    func loadDataByDefault () {
        userCityName.text = getSaveNamedOfCity()
    }
    
    
    func getSaveNamedOfCity () -> String {
        var NametoReturn: String = ""
        
        do {
            if let CityNameFromPlist: NSString = try plistGet(tempItemsInKlass.nameTemporaryForSave, forPlistNamed: tempItemsInKlass.nameOfPList, needToSaveBetweenSessions: true) as? NSString{
                
                NametoReturn = CityNameFromPlist as String
            }
        }
            
        catch{
            NametoReturn = ""
        }
        
        return NametoReturn
    }
    
    func saveNameOfCity() {
        
        do {
            if userCityName != nil {
                try plistSet(userCityName.text!, forKey: tempItemsInKlass.nameTemporaryForSave, inPlistNamed: tempItemsInKlass.nameOfPList, needToSaveBetweenSessions: true)
            }
            
        }catch{ }
        
    }
    
}
