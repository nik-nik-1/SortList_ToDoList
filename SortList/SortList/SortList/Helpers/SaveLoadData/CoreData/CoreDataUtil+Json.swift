//
//  CoreDataUtil+Json.swift
//  SortList
//
//  Created by mc373 on 29.03.16.
//  Copyright © 2016 Local. All rights reserved.
//

import CoreData

extension CoreDataUtil {
    
    static func saveJsonInCoreData (jsonData:NSData){
        
        //        guard jsonData != nil else {
        //            return
        //        }
        
        //if let jsonData as NSData{
        if let structItem = JsonWork.getWeatherStructureFromJsonData (jsonData) {
            let entityNameOfObject = WeatherItem.getEntityNameOfObject()
            //Erese all data in CoreData
            CoreDataUtil.deleteAllData(entityNameOfObject)
            
            
            let moc = CoreDataUtil.getManagedObjectContext(entityNameOfObject)
            WeatherItem.insertWeatheItemWithItem(structItem, context: moc)
            CoreDataUtil.saveContext(moc)
        }
    }
    
}
