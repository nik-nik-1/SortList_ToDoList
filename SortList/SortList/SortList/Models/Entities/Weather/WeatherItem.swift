//
//  weatherItem.swift
//  SortList
//
//  Created by mc373 on 23.03.16.
//  Copyright © 2016 Local. All rights reserved.
//

import Foundation
import CoreData


class WeatherItem : NSManagedObject {
    
    static let elementDictOfClass = WeatherItem.getElementDictOfClass()
    
    private static let entityName: NSString = "CurrentWeatherForLocation"
    private let entityName: NSString = WeatherItem.entityName
    
    class func getEntityNameOfObject() -> String {
        return entityName as String
    }
    
    static func insertNewObjectIntoContext(context: NSManagedObjectContext) -> NSManagedObject? {
        return NSEntityDescription.insertNewObjectForEntityForName(entityName as String, inManagedObjectContext: context)
    }
    
    static func insertWeatheItemWithItem(structOfItems: WeatherItemStructure,  context: NSManagedObjectContext) -> NSManagedObject? {
        let weatherItem: WeatherItem = insertNewObjectIntoContext(context) as! WeatherItem
        
        weatherItem.id                  = structOfItems.id
        weatherItem.name                = structOfItems.name
        weatherItem.country             = structOfItems.country
        weatherItem.weatherMain         = structOfItems.weatherMain
        weatherItem.weatherDescription  = structOfItems.weatherDescription
        weatherItem.weathrIcon          = structOfItems.weathrIcon
        weatherItem.mainTemp            = structOfItems.mainTemp
        weatherItem.mainPressure        = structOfItems.mainPressure
        weatherItem.mainHumidity        = structOfItems.mainHumidity
        weatherItem.mainTemp_min        = structOfItems.mainTemp_min
        weatherItem.mainTemp_max        = structOfItems.mainTemp_max
        weatherItem.windSpeed           = structOfItems.windSpeed
        weatherItem.windDeg             = structOfItems.windDeg
        
        return weatherItem
    }
    
    static func allWatherItems() -> [WeatherItem]? {
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        //        let predicate = NSPredicate(format: "item BEGINSWITH %@", "sd")
        let array = CoreDataUtil.fetchEntity(entityName as String, predicate: nil, sortDescriptors: [nameSort]) as? [WeatherItem]
        
        return array
    }
    
    static func getElementDictOfClass () -> [String: String]{
        var Dict = [String: String]()
        Dict.updateValue("City ID",                             forKey: "id")
        Dict.updateValue("City name",                           forKey: "name")
        Dict.updateValue("Country code",                        forKey: "country")
        Dict.updateValue("Group of weather parameters",         forKey: "weatherMain")
        Dict.updateValue("Weather condition within the group",  forKey: "weatherDescription")
        Dict.updateValue("Weather icon id",                     forKey: "weathrIcon")
        Dict.updateValue("Temperature. Metric: Celsius",        forKey: "mainTemp")
        Dict.updateValue("Atmospheric pressure, hPa",           forKey: "mainPressure")
        Dict.updateValue("Humidity, %",                         forKey: "mainHumidity")
        Dict.updateValue("Minimum temperature at the moment",   forKey: "mainTemp_min")
        Dict.updateValue("Maximum temperature at the moment",   forKey: "mainTemp_max")
        Dict.updateValue("Wind speed. Metric: meter/sec",       forKey: "windSpeed")
        Dict.updateValue("Wind direction, degrees",             forKey: "windDeg")
        
        return Dict
    }
    
    //MARK: getting value in class Weather like as "class[nameOfParam(String)]", not class.nameOfParam
    subscript(name: String) -> String? {
        
        // 1
        get {
            var valueToReturn:String?
            
            //get value in dictionary
            if let _ = WeatherItem.elementDictOfClass [name]{
                switch name {
                case "id":                  valueToReturn = self.id.getStringFormat (0)
                case "name":                valueToReturn = self.name
                case "country":             valueToReturn = self.country
                case "weatherMain":         valueToReturn = self.weatherMain
                case "weatherDescription":  valueToReturn = self.weatherDescription
                case "weathrIcon":          valueToReturn = self.weathrIcon
                case "mainTemp":            valueToReturn = self.mainTemp.getStringFormat (2)
                case "mainPressure":        valueToReturn = self.mainPressure.getStringFormat (2)
                case "mainHumidity":        valueToReturn = self.mainHumidity.getStringFormat (2)
                case "mainTemp_min":        valueToReturn = self.mainTemp_min.getStringFormat (2)
                case "mainTemp_max":        valueToReturn = self.mainTemp_max.getStringFormat (2)
                case "windSpeed":           valueToReturn = self.windSpeed.getStringFormat (2)
                case "windDeg":             valueToReturn = self.windDeg.getStringFormat (2)
                default:
                    //default variable
                    valueToReturn = ""
                }
            } else {
                //default variable
                valueToReturn = ""
            }
            return valueToReturn
        }
    }
}

//private extension Int64 {
//    func getStringFormat (digits: Int = 2)  -> String  {return String(format: "%.\(digits)f", self)}
//}
//private extension Double {
//    func getStringFormat (digits: Int = 2)  -> String  {return String(format: "%.\(digits)f", self)}
//}


