//
//  WeatherManager.swift
//  SortList
//
//  Created by mc373 on 29.03.16.
//  Copyright © 2016 Local. All rights reserved.
//
import UIKit

class WeatherManager {
    
    static func loadDataOfWeatheFromUrlToCoreData (cityName: String?, callBack: ((data: NSData!) -> Void)?){
        
        HttpRequestWork.connectToWS(cityName) { data, response, error in
            
            if error != nil {
                if error.domain == NSURLErrorDomain && error.code == NSURLErrorTimedOut {
                    print("timed out") // note, `response` is likely `nil` if it timed out
                }
            } else {
                //all OK, i.e. error = nil
                CoreDataUtil.saveJsonInCoreData (data)
                
                callBack?(data: data)
                //               NSNotificationCenter.defaultCenter().postNotificationName("updateWeatherTableFromAnotherModule", object: nil)
                //
            }
        }
        
    }
}
