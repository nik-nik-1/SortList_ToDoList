//
//  HttpRequestWork.swift
//  SortList
//
//  Created by mc373 on 18.03.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit


class  HttpRequestWork {
    
    static func connectToWS(cityName: String? = "Kathmandu", callBack: ((data: NSData!, response: NSURLResponse!, error: NSError!) -> Void)?) {
        
        let cityNameParam:String = cityName ?? ""
//        let urlPath: String = "http://api.openweathermap.org/data/2.5/weather?q=\(cityNameParam)&mode=json&units=metric&appid=9bd00823dba3f57648fd6bae859d7d34"
        let urlPath: String = GeneralPurposeParametres.weatherUrlString.replace(GeneralPurposeParametres.symbolOfCityNameToReplaceInWeatherUrlString, withString:"\(cityNameParam)")
        
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
            callBack?(data: data, response: response, error: error)
            
        }
//        NSNotificationCenter.defaultCenter().postNotificationName("updateWeatherTableFromAnotherModule", object: nil)
        
        
        task.resume()
    }
    
}
