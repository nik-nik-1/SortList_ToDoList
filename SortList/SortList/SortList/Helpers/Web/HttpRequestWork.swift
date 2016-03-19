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
        
        if let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&mode=json&appid=b1b15e88fa797225412429c1c50c122a") {
            let session = NSURLSession.sharedSession() // preferred way to for any URL request
            
            let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
                defer { // read: "finally." That is, "here's something I want you to do later, no matter what."
                    
                }
                
                if error != nil {
                    print("Whoops, something went wrong with the connection! Details: \(error!.localizedDescription); \(error!.userInfo)")
                }
                else if data != nil {
                    do {
                        let raw = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                        if let json = raw as? [[String: AnyObject]] { // The idea: cast raw into an array of dictionaries
                            for entry in json {
//                                print("Train to \(entry["PlatformKey"]) is arriving in approximately \(entry["TimeRemaining"]) at \(entry["Time"])")
                                
                                
                                
                            }
                        }
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
    
}
