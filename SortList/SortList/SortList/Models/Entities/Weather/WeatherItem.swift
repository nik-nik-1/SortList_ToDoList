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
        
        weatherItem.name                = structOfItems.name
        weatherItem.id                  = structOfItems.id
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
    
    subscript(name: String) -> String {
        // 1
        get {
//            // 2
//            precondition(index < self.array.count,
//                "Index out-of-bounds")
//            
//            // 3
//            let key = self.array[index]
            
            // 4
            let value = self[name] as String
            
            // 5
            return value
        }
    }
    
}


// fields "id" need be set as first value!
class WeatherItemStructure {
    
    var id: Int64                   = 0{
        willSet{
            erraseAllItem ()
        }
    }
    var name: String?               = ""
    var country: String?            = ""
    var weatherMain: String?        = ""
    var weatherDescription: String? = ""
    var weathrIcon: String?         = ""
    var mainTemp: Double            = 0
    var mainPressure: Int64         = 0
    var mainHumidity: Int64         = 0
    var mainTemp_min: Double        = 0
    var mainTemp_max: Int64         = 0
    var windSpeed: Int64            = 0
    var windDeg: Int64              = 0
    
    init () {
    }
    
    
    func erraseAllItem (){
        id = 0
        name = ""
        country = ""
        weatherMain = ""
        weatherDescription = ""
        weathrIcon = ""
        mainTemp = 0
        mainPressure = 0
        mainHumidity = 0
        mainTemp_min = 0
        mainTemp_max = 0
        windSpeed = 0
        windDeg = 0
    }
}

struct elementDictStructure {
    var name = ""
    var description = ""
}
