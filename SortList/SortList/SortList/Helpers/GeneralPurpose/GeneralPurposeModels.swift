//
//  GeneralPurposeModel.swift
//  SortList
//
//  Created by mc373 on 30.03.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

//MARK: Weather adding
struct WeatherStructInfo {
	let nameTemporaryForSave: String    = "nameOfWeatherCity"
	let nameOfPList: String             = "mainPList"
}

// fields "id" need be set as first value!
struct WeatherItemStructure {
	// swiftlint:disable:next variable_name
	var id: Int64                   = 0
	var name: String                = ""
	var country: String             = ""
	var weatherMain: String         = ""
	var weatherDescription: String  = ""
	var weathrIcon: String          = ""
	var mainTemp: Double            = 0
	var mainPressure: Int64         = 0
	var mainHumidity: Int64         = 0
	var mainTempMin: Double         = 0
	var mainTempMax: Double         = 0
	var windSpeed: Int64            = 0
	var windDeg: Int64              = 0

}

struct ElementDictStructure {
	var name            = ""
	var description     = ""
}

struct RigthParametersOfColorForDrawing {

	var сolor04a: UIColor
	var сolor02a: UIColor
}
