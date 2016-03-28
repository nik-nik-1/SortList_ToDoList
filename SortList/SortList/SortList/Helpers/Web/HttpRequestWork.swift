//
//  HttpRequestWork.swift
//  SortList
//
//  Created by mc373 on 18.03.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

protocol getSomeWorkInWeatherControl {
    func updateWeatherTableView ()
}

class  HttpRequestWork {
    
    
    static func loadDataOfWeatheFromUrlToCoreData (cityName: String?){
        //        let jsonData = getHttpConnectAndparseJSONforWeather (cityName)
        //        saveJsonInCoreData (jsonData)
        
        
        
        connectToWS(cityName) { data, response, error in
            
            if error != nil {
                if error.domain == NSURLErrorDomain && error.code == NSURLErrorTimedOut {
                    print("timed out") // note, `response` is likely `nil` if it timed out
                }
            }else{
                //all OK, i.e. error = nil
                saveJsonInCoreData (data)
                
//                NSNotificationCenter.defaultCenter().postNotificationName("updateWeatherTableFromAnotherModule", object: nil)
//           
            }
        }
        
    }
    
    private static func connectToWS(cityName: String? = "Kathmandu", callBack: ((data: NSData!, response: NSURLResponse!, error: NSError!) -> Void)?) {
        
        let cityNameParam:String = cityName ?? ""
        let urlPath: String = "http://api.openweathermap.org/data/2.5/weather?q=\(cityNameParam)&mode=json&units=metric&appid=9bd00823dba3f57648fd6bae859d7d34"
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            callBack?(data: data, response: response, error: error)
            
//            dispatch_async(dispatch_get_main_queue()) {
//                self.tableView.reloadData()
//            }
            
            return
        }
//        NSNotificationCenter.defaultCenter().postNotificationName("updateWeatherTableFromAnotherModule", object: nil)
        
        
        task.resume()
    }
    
    private static func saveJsonInCoreData (jsonData:NSData){
        
        //        guard jsonData != nil else {
        //            return
        //        }
        
        //if let jsonData as NSData{
        if let structItem = parseJsonInSpecModule (jsonData) {
            let EntityNameOfObject = WeatherItem.getEntityNameOfObject()
            //Erese all data in CoreData
            CoreDataUtil.deleteAllData(EntityNameOfObject)
            
            
            let moc = CoreDataUtil.getManagedObjectContext(EntityNameOfObject)
            WeatherItem.insertWeatheItemWithItem(structItem, context: moc)
            CoreDataUtil.saveContext(moc)
        }
        //}
    }
    
    
    private static  func parseJsonInSpecModule (data:NSData) -> WeatherItemStructure?{
        var structItem: WeatherItemStructure?
        do {
            let parseJSON = try JSON.parseData(data)
            
            //            if json["name"].isUndefined {
            //               throw .MissingName
            //            }
            //
            //            if json["info"]["age"].isUndefined {
            ////                throw .MissingAge
            //            }
            
            //            let model = MyModel(
            //                name: json["name"].stringValue!
            //                age: json["info"]["age"].intValue!
            //                married: json["status"]["married"].boolValue ?? false
            //                firstCar: json["cars"][0].stringValue ?? ""
            //            )
            //print ("City name: \(json["name"].stringValue!), longitude: \(String(json["coord"]["lon"].numberValue!))")
            
            
            //Generate temp.Struct for CoreData
            structItem = WeatherItemStructure()
            structItem!.id = parseJSON["sys"]["id"].int64Value! as Int64
            structItem!.name = parseJSON["name"].stringValue! as String
            structItem!.country = parseJSON["sys"]["country"].stringValue! as String
            //            if let weatherArray = parseJSON["weather"].arrayValue {
            //                if weatherArray.count > 0 {
            ////                    let valueOfWeatherArray = weatherArray[0]
            ////                    let weatherMain = valueOfWeatherArray["main"]!!.stringValue as String
            //                    for entry in weatherArray {
            //
            //                    }
            //
            //                }
            ////                structItem!.weatherMain         = parseJSON["weather"]["main"].stringValue! as String
            ////                structItem!.weatherDescription  = parseJSON["weather"]["description"].stringValue! as String
            ////                structItem!.weathrIcon          = parseJSON["weather"]["icon"].stringValue! as String
            //
            //            }
            
            
            structItem!.mainTemp = parseJSON["main"]["temp"].doubleValue! as Double
            structItem!.mainPressure = parseJSON["main"]["pressure"].int64Value! as Int64
            structItem!.mainHumidity = parseJSON["main"]["humidity"].int64Value! as Int64
            structItem!.mainTemp_min = parseJSON["main"]["temp_min"].doubleValue! as Double
            structItem!.mainTemp_max = parseJSON["main"]["temp_max"].doubleValue! as Double
            structItem!.windSpeed = parseJSON["wind"]["speed"].int64Value! as Int64
            //structItem!.windDeg = parseJSON["wind"]["deg"].int64Value! as Int64
        }
            
        catch {
            // Handle error
        }
        return structItem
    }
    
    
    //    class RemoteAPI {
    //        func getData(cityName: String? = "Kathmandu", completionHandler: ((NSArray!, NSError!) -> Void)!) -> Void {
    //            let cityNameParam:String = cityName ?? ""
    //            let URLString: String = "http://api.openweathermap.org/data/2.5/weather?q=\(cityNameParam)&mode=json&units=metric&appid=9bd00823dba3f57648fd6bae859d7d34"
    //            let url: NSURL = NSURL(string: URLString)!
    //            let ses = NSURLSession.sharedSession()
    //            let task = ses.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
    //                if (error != nil) {
    //                    return completionHandler(nil, error)
    //                }
    //
    //                var error: NSError?
    //                do {
    //                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
    //                    return completionHandler(json["results"] as! [NSDictionary], nil)
    //                }
    //                catch {
    //                    print("Whoops, cannot convert data to JSON!")
    //                    return completionHandler(nil, error)
    //                }
    //
    //            })
    //            task.resume()
    //        }
    //    }
    
    
    
    
    //    private static func getHttpConnectAndparseJSONforWeather (cityName: String? = "Kathmandu") -> NSData? {
    //
    //        var valueForReturn: NSData?
    //
    //        let cityNameParam:String = cityName ?? ""
    //        let URLString: String = "http://api.openweathermap.org/data/2.5/weather?q=\(cityNameParam)&mode=json&units=metric&appid=9bd00823dba3f57648fd6bae859d7d34"
    //
    //        if let url = NSURL(string: URLString) {
    //            let session = NSURLSession.sharedSession() // preferred way to for any URL request
    //
    //            let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
    //                defer { // read: "finally." That is, "here's something I want you to do later, no matter what."
    //
    //                }
    //
    //                if error != nil {
    //                    print("Whoops, something went wrong with the connection! Details: \(error!.localizedDescription); \(error!.userInfo)")
    //                }
    //                else if data != nil {
    //                    do {
    //
    //                        //                        let jsonRaw = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
    //                        //
    //                        //                        if let parseJSON = jsonRaw {
    //                        //                            if parseJSON.count>0 {
    //                        //                                //let keys = parseJSON["main"]!.allKeys
    //                        //
    //                        //                              // parseJSON["name"]
    //                        ////
    //                        //
    //                        ////                                let EntityNameOfObject = WeatherItem.getEntityNameOfObject()
    //                        ////
    //                        ////                                //Erese all data in CoreData
    //                        ////                                CoreDataUtil.deleteAllData(EntityNameOfObject)
    //                        ////
    //                        ////                                //Generate temp.Struct for CoreData
    //                        ////                                let structItem = WeatherItemStructure()
    //                        ////                                //structItem.id = parseJSON["id"] as! Int64
    //                        ////                                structItem.name = parseJSON["name"] as! String
    //                        ////
    //                        ////
    //                        ////                                let moc = CoreDataUtil.getManagedObjectContext(EntityNameOfObject)
    //                        ////                                WeatherItem.insertWeatheItemWithItem(structItem, context: moc)
    //                        ////                                CoreDataUtil.saveContext(moc)
    //                        //
    //                        //                             }
    //                        //                        }
    //
    //
    //                        //                        if let json = jsonRaw as? [[String: AnyObject]] { // The idea: cast raw into an array of dictionaries
    //                        //                            for entry in json {
    //                        ////                                print("Train to \(entry["PlatformKey"]) is arriving in approximately \(entry["TimeRemaining"]) at \(entry["Time"])")
    //                        //                                print ("City name: \(entry["name"]), longitude: \(entry["coord"]!["lon"])")
    //                        //
    //                        //
    //                        //                            }
    //                        //                        }
    //
    //                        //parseJsonInSpecModule (data!)
    //
    //
    //                    }
    //                    catch {
    //                        print("Whoops, cannot convert data to JSON!")
    //                    }
    //                }
    //
    //                }
    //
    //            )
    //
    //
    //            task.resume()
    //        }
    //        else {
    //            print("Whoops, something is wrong with the URL")
    //        }
    //        
    //        return valueForReturn!
    //        
    //    }
    
    
    
    
    
}
