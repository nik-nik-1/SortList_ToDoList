//
//  NRswiftPlist.swift
//
//  Created by Norman Russo on 04/11/14.
//  Copyright (c) 2014 Norman Russo. All rights reserved.
//

//INFO ++++
//Original (first version) was pasting from: https://github.com/portapipe/NRSimplePlist
//INFO ----

import UIKit

//class NRSwiftPlist {
//
//}

enum NRSimplePlistError: ErrorType {
    case Fatal(String)
}

func plistGet(key:String, forPlistNamed:String, needToSaveBetweenSessions:Bool = true) throws -> AnyObject? {
    
    //if let path:String = NSBundle.mainBundle().pathForResource(forPlistNamed, ofType: "plist"){
    if let path:String = getPathToSaveData(forPlistNamed, needToSaveBetweenSessions: needToSaveBetweenSessions){
        return try getPlistKeyValue(key, path: path)
        
    } else {
        print("File '\(forPlistNamed)' not found")
    }
    
    return nil
}


func plistSet(newValue:AnyObject, forKey:String, inPlistNamed:String, needToSaveBetweenSessions:Bool = true) throws {
    
    // if let path: NSString = NSBundle.mainBundle().pathForResource(inPlistNamed, ofType: "plist") {
    if let path:String = getPathToSaveData(inPlistNamed, needToSaveBetweenSessions: needToSaveBetweenSessions) {
        let fileManager : NSFileManager = NSFileManager.defaultManager()
        
        if fileManager.fileExistsAtPath(path){
            
            try setPlistValue (newValue, forKey:forKey, path: path)
            
        } else {
            print("File '\(inPlistNamed)' not found setting value \(newValue) for key \(forKey)")
        }
        
    }else{
        print("NRswiftPlist - The file in the path doesn't exists")
    }
}

//MARK: Internal function Save & Load Data

private func getPathToSaveData (inPlistNamed:String, needToSaveBetweenSessions:Bool = true) -> String{
    
    var path: String = ""
    
    if needToSaveBetweenSessions {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        path = (documentDirectory as NSString).stringByAppendingPathComponent("\(inPlistNamed)"+".plist")
        
//      File NotExist -> Let's  Create file in directory
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(path) {
            
            let sourceFilePath: String = getPathOfPListFileInDirectory(inPlistNamed)
            
            do {
//                print("Copying Plist Into Documents Directory!")
                try fileManager.copyItemAtPath(sourceFilePath, toPath: path)
            }
                
            catch{
                NSLog("NRSimplePlist - Error Copying plist file '\(path)',")
            }
        }else{
           //All OK!
            //This can be used to delete file from documents directory
            //fileManager.removeItemAtPath(path, error: nil)
        }

        
    }else{
        path = getPathOfPListFileInDirectory(inPlistNamed)
    }
    return path
}

private func getPathOfPListFileInDirectory(inPlistNamed:String) -> String{
    return NSBundle.mainBundle().pathForResource(inPlistNamed, ofType: "plist")!
}


private func getPlistKeyValue(key:String, path: String) throws -> AnyObject? {
    
    if let plistData = NSData(contentsOfFile: path) {
        
        let formats: UnsafeMutablePointer<NSPropertyListFormat> = UnsafeMutablePointer()
        //var plist = NSPropertyListSerialization.propertyListWithData(plistData, options: 0, format: formats, error: &error) as NSDictionary
        do {
            let plist = try NSPropertyListSerialization.propertyListWithData(plistData, options: .Immutable, format: formats) as! NSDictionary
            
            if (path=="") {
                //                    NSLog("NRSimplePlist - Errore LETTURA file plist '\(path)'")
                NSLog("NRSimplePlist - Error READING plist file '\(path)'")
                
                throw NRSimplePlistError.Fatal("NRSimplePlist - Error READING plist file '\(path)'")
            }
            
            if let tipo = plist.valueForKey(key) {
                return tipo
            }
        } catch let error1 as NSError {
            //                NSLog("NRSimplePlist - Errore LETTURA file plist '\(path)', errore = '\(error1.localizedDescription)'")
            NSLog("NRSimplePlist - Error READING plist file '\(path)', error = '\(error1.localizedDescription)'")
            
            throw error1
        } catch {
            //                NSLog("NRSimplePlist - Errore LETTURA file plist '\(path)'")
            NSLog("NRSimplePlist - Error READING plist file '\(path)',")
            
            throw NRSimplePlistError.Fatal("NRSimplePlist - Error READING plist property")
        }
        return nil
    }
    
    return nil
}


private func setPlistValue (newValue:AnyObject, forKey:String, path: String) throws {
    
    if let plistData = NSData(contentsOfFile: path as String) {
        var array:NSMutableDictionary = NSMutableDictionary()
        let formats: UnsafeMutablePointer<NSPropertyListFormat> = UnsafeMutablePointer()
        //var plist = NSPropertyListSerialization.propertyListWithData(plistData, options: .MutableContainers, format: formats, error: &error) as NSMutableDictionary
        
        do {
            let plist = try NSPropertyListSerialization.propertyListWithData(plistData, options: .MutableContainers, format: formats) as! NSMutableDictionary
            if (path=="") {
                //                        NSLog("NRSimplePlist - Errore LETTURA file plist '\(path)'")
                NSLog("NRSimplePlist - Error READING plist file '\(path)'")
                
                throw NRSimplePlistError.Fatal("NRSimplePlist - Error READING plist file '\(path)'")
            }
            
            array = plist.mutableCopy() as! NSMutableDictionary
            //print(path)
            array.setObject(newValue, forKey: forKey)
            array.writeToFile(path as String, atomically: true)
        } catch let error1 as NSError {
            //                    NSLog("NRSimplePlist - Errore LETTURA file plist '\(path)', errore = '\(error1.localizedDescription)'")
            NSLog("NRSimplePlist - Error READING plist file '\(path)', error = '\(error1.localizedDescription)'")
            
            throw error1
        }
    }
}