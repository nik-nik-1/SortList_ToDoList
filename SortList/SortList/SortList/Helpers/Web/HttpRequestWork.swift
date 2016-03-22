//
//  HttpRequestWork.swift
//  SortList
//
//  Created by mc373 on 18.03.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit


class  HttpRequestWork {
    
    
    static func getHttpConnectAndparseJSONforWeather (cityName: String = "Kathmandu") {
        
        if let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&mode=json&units=metric&appid=b1b15e88fa797225412429c1c50c122a") {
            let session = NSURLSession.sharedSession() // preferred way to for any URL request
            
            let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                defer { // read: "finally." That is, "here's something I want you to do later, no matter what."
                    
                }
                
                if error != nil {
                    print("Whoops, something went wrong with the connection! Details: \(error!.localizedDescription); \(error!.userInfo)")
                }
                else if data != nil {
                    do {
                        
                        let jsonRaw = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                        
                        if let parseJSON = jsonRaw {
                            if parseJSON.count>0 {
                                //let keys = parseJSON["main"]!.allKeys
                                
                              // parseJSON["name"]
                                
                            
                             }
                        }
                        
                        
//                        if let json = jsonRaw as? [[String: AnyObject]] { // The idea: cast raw into an array of dictionaries
//                            for entry in json {
////                                print("Train to \(entry["PlatformKey"]) is arriving in approximately \(entry["TimeRemaining"]) at \(entry["Time"])")
//                                print ("City name: \(entry["name"]), longitude: \(entry["coord"]!["lon"])")
//                                
//                                
//                            }
//                        }
                        
                        //parseJsonInSpecModule (data!)
                        
                        
                    }
                    catch {
                        print("Whoops, cannot convert data to JSON!")
                    }
                }
                
            })
            task.resume()
        }
        else {
            print("Whoops, something is wrong with the URL")
        }
        
    }
    
    
  static  func parseJsonInSpecModule (data:NSData) {
    
        do {
            let json = try JSON.parseData(data)
            
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
            print ("City name: \(json["name"].stringValue!), longitude: \(String(json["coord"]["lon"].numberValue!))")
        }
        catch {
            // Handle error
        }

    }
    
    
}
