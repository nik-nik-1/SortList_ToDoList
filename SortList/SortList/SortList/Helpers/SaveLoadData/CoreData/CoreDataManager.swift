//
//  CoreDataManager.swift
//  SortList
//
//  Created by Vitaly on 3/12/16.
//  Copyright © 2016 Local. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class CoreDataManager {


	private var defaultURLForResource: String!

	//MARK: Init()
	private init() {
		defaultInitClass()
	}

	private init(defUrlRes: String?) {
		//by the first-  let's init variable with default parametres

		if let tempDefUrl = defUrlRes as String! {
			defaultURLForResource = tempDefUrl
		} else {
			defaultURLForResource = CoreDataManager.getDefaultNameOfUsingDataType()
		}
	}

	private func defaultInitClass () {
		defaultURLForResource = CoreDataManager.getDefaultNameOfUsingDataType()
	}

	static func getDefaultNameOfUsingDataType() -> String {
		return GeneralPurposeParametres.defaultNameOfUsingDataType
	}

	//MARK: Core Data work
	private(set) var sourceStoreType: String = NSSQLiteStoreType

	lazy private(set) var managedObjectModel: NSManagedObjectModel = {

		let modelURL = NSBundle.mainBundle().URLForResource(self.defaultURLForResource,
		                                                    withExtension: "momd")!
		return NSManagedObjectModel(contentsOfURL: modelURL)!

	}()


	lazy private(set) var managedObjectContext: NSManagedObjectContext = {
		let coordinator = self.persistentStoreCoordinator
		var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
		managedObjectContext.persistentStoreCoordinator = coordinator

		//save default instanse name which was create by initializarion
		//        managedObjectContext.usedURLForResource = self.defaultURLForResource

		return managedObjectContext
	}()

	lazy private(set) var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
		//  The persistent store coordinator for the application.
		// This implementation creates and returns a coordinator,
		// having added the store for the application to it.
		// This property is optional since there are legitimate error
		// conditions that could cause the creation of the store to fail.

		// Create the coordinator and store
		let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
		let url = self.sourceStoreURL()
		var failureReason = "There was an error creating or loading the application's saved data."
		do {
			try coordinator.addPersistentStoreWithType(NSSQLiteStoreType,
			                                           configuration: nil,
			                                           URL: url,
			                                           options: nil)
		} catch {
			// Report any error we got.
			var dict = [String: AnyObject]()
			dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
			dict[NSLocalizedFailureReasonErrorKey] = failureReason

			dict[NSUnderlyingErrorKey] = error as NSError
			let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
			// Replace this with code to handle the error appropriately.
			// abort() causes the application to generate a crash log and terminate.
			// You should not use this function in a shipping application,
			// although it may be useful during development.

			NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
			abort()
		}

		return coordinator

	}()

	private func sourceStoreURL() -> NSURL {

		let appDelegate = (UIApplication.sharedApplication().delegate as? AppDelegate)!

		// swiftlint:disable:next line_length
		return appDelegate.applicationDocumentsDirectory().URLByAppendingPathComponent("\(self.defaultURLForResource).sqlite")
	}

	//   static let sharedInstance = CoreDataManager()

	private static var dictionaryOfInstance = [String: CoreDataManager?]()

	static func getSharedInstance (typeOut: String? = nil) -> CoreDataManager {
		let instanseToReturn: CoreDataManager

		let key = typeOut ?? getDefaultNameOfUsingDataType()

		if let val = dictionaryOfInstance[key] {
			//if key exist - get it from the stack
			instanseToReturn = val!
		} else {
			instanseToReturn = CoreDataManager(defUrlRes: typeOut)
			//add instanse to dictionary
			dictionaryOfInstance[key] = instanseToReturn
		}

		return instanseToReturn
	}

}
