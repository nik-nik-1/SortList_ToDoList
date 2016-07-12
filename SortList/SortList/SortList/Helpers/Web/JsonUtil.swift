//
//  JsonUtil.swift
//  SortList
//
//  Created by mc373 on 29.03.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class JsonUtil {

    static func getWeatherStructureFromJsonData (data: NSData) -> WeatherItemStructure? {
        return parseJsonInSpecModule (data)
    }

    private static  func parseJsonInSpecModule (data: NSData) -> WeatherItemStructure? {
        var structItem: WeatherItemStructure?
        do {

            let parseJSON = try JSON.parseData(data)

            //Generate temp.Struct for CoreData
            structItem = WeatherItemStructure()
           // structItem?.id = parseJSON["sys"]["id"].int64Value! as Int64
            structItem?.name = parseJSON["name"].stringValue! as String
            structItem?.country = parseJSON["sys"]["country"].stringValue! as String
            structItem?.mainTemp = parseJSON["main"]["temp"].doubleValue! as Double
            structItem?.mainPressure = parseJSON["main"]["pressure"].int64Value! as Int64
            structItem?.mainHumidity = parseJSON["main"]["humidity"].int64Value! as Int64
            structItem?.mainTempMin = parseJSON["main"]["temp_min"].doubleValue! as Double
            structItem?.mainTempMax = parseJSON["main"]["temp_max"].doubleValue! as Double
            structItem?.windSpeed = parseJSON["wind"]["speed"].int64Value! as Int64
            //structItem!.windDeg = parseJSON["wind"]["deg"].int64Value! as Int64
        } catch {
            // Handle error
        }
        return structItem
    }
}
