//
//  CurrentWeatherForLocation+CoreDataProperties.swift
//  SortList
//
//  Created by mc373 on 23.03.16.
//  Copyright © 2016 Local. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension WeatherItem {

    @NSManaged var name: String?
    @NSManaged var id: Int64
    @NSManaged var country: String?
    @NSManaged var weatherMain: String?
    @NSManaged var weatherDescription: String?
    @NSManaged var weathrIcon: String?
    @NSManaged var mainTemp: Double
    @NSManaged var mainPressure: Int64
    @NSManaged var mainHumidity: Int64
    @NSManaged var mainTemp_min: Double
    @NSManaged var mainTemp_max: Int64
    @NSManaged var windSpeed: Int64
    @NSManaged var windDeg: Int64

}
