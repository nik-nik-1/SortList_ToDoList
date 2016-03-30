//
//  GeneralPurposeModel.swift
//  SortList
//
//  Created by mc373 on 30.03.16.
//  Copyright © 2016 Local. All rights reserved.
//


//MARK: Weather adding
struct WeatherStructInfo {
    let nameTemporaryForSave: String    = "nameOfWeatherCity"
    let nameOfPList: String             = "mainPList"
}

// fields "id" need be set as first value!
struct WeatherItemStructure {
    
    var id: Int64                   = 0
    var name: String                = ""
    var country: String             = ""
    var weatherMain: String         = ""
    var weatherDescription: String  = ""
    var weathrIcon: String          = ""
    var mainTemp: Double            = 0
    var mainPressure: Int64         = 0
    var mainHumidity: Int64         = 0
    var mainTemp_min: Double        = 0
    var mainTemp_max: Double        = 0
    var windSpeed: Int64            = 0
    var windDeg: Int64              = 0
    
}

struct elementDictStructure {
    var name            = ""
    var description     = ""
}
