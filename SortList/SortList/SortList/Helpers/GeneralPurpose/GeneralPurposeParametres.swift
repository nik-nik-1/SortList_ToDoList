//
//  GeneralPurposeParametres.swift
//  SortList
//
//  Created by mc373 on 29.03.16.
//  Copyright © 2016 Local. All rights reserved.
//

// MARK: General parametres
class GeneralPurposeParametres {

	//Weather Web Data Work

	static let symbolOfCityNameForUrlString = "📡"
	// swiftlint:disable:next line_length
	static let weatherUrlString = "http://api.openweathermap.org/data/2.5/weather?q=\(GeneralPurposeParametres.symbolOfCityNameForUrlString)&mode=json&units=metric&appid=9bd00823dba3f57648fd6bae859d7d34"

	//Weather Controller
	static let tempItemsInKlass = WeatherStructInfo()

	//Weather CoreDataUtil
	static let arrayOfUsetDatabaseName: [String] = ["SortList", "WeatherDataModel"]
	static let dictionaryOfEntityName: [String: String] = [
		//DataBaseNameFromDatabaseName
		"SortList":"SortList",
		"WeatherDataModel":"WeatherDataModel",
		//DataBaseNameFromInstanceName
		ToDoItem.getEntityNameOfObject():"SortList",
		WeatherItem.getEntityNameOfObject():"WeatherDataModel",
		"LocationsOfWeather":"WeatherDataModel"]

	//Weather CoreDataManager
	static let defaultNameOfUsingDataType = "SortList"
}
