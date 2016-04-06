//
//  JsonUtil.swift
//  SortList
//
//  Created by mc373 on 29.03.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class JsonUtil {
    
    static func getWeatherStructureFromJsonData (data: NSData) -> WeatherItemStructure?{
        return parseJsonInSpecModule (data)
    }
    
    private static  func parseJsonInSpecModule (data: NSData) -> WeatherItemStructure? {
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
           // structItem?.id = parseJSON["sys"]["id"].int64Value! as Int64
            structItem?.name = parseJSON["name"].stringValue! as String
            structItem?.country = parseJSON["sys"]["country"].stringValue! as String
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
            
            
            structItem?.mainTemp = parseJSON["main"]["temp"].doubleValue! as Double
            structItem?.mainPressure = parseJSON["main"]["pressure"].int64Value! as Int64
            structItem?.mainHumidity = parseJSON["main"]["humidity"].int64Value! as Int64
            structItem?.mainTemp_min = parseJSON["main"]["temp_min"].doubleValue! as Double
            structItem?.mainTemp_max = parseJSON["main"]["temp_max"].doubleValue! as Double
            structItem?.windSpeed = parseJSON["wind"]["speed"].int64Value! as Int64
            //structItem!.windDeg = parseJSON["wind"]["deg"].int64Value! as Int64
        }
            
        catch {
            // Handle error
        }
        return structItem
    }
}
