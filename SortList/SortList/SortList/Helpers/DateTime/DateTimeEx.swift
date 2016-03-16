//
//  Date.swift
//  SortList
//
//  Created by mc373 on 12.02.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

//class Date: NSObject {

//class Date {
extension NSDate{
    
    class func from(year year:Int, month:Int, day:Int, hour:Int?=nil, minute:Int?=nil, second:Int?=nil) -> NSDate {
        let c = NSDateComponents()
        c.year      = year
        c.month     = month
        c.day       = day
        c.hour      = hour == nil ? 00 : hour!
        c.minute    = minute == nil ? 00 : minute!
        c.second    = second == nil ? 00 : second!
        
        let gregorian   = NSCalendar(identifier:NSCalendarIdentifierGregorian)
        let date        = gregorian!.dateFromComponents(c)
        
        return date!
    }
    
    class func parse(dateStr:String, format:String="yyyy-MM-dd' 'HH:mm:ss") -> NSDate {
        let dateFmt         = NSDateFormatter()
        dateFmt.timeZone    = NSTimeZone.defaultTimeZone()
        dateFmt.dateFormat  = format
        
        return dateFmt.dateFromString(dateStr)!
    }
    
    class func parseForMainTableView(dateNSDate:NSDate) -> String {
        //return parse(dateStr, format:"dd MM")
        let dateFmt           = NSDateFormatter()
        dateFmt.dateFormat    = "dd MMM"//
        
        let dateStr = dateFmt.stringFromDate(dateNSDate)
        return dateStr
    }
    
    class func parseForDetailTableView(dateNSDate:NSDate) -> String {
        //return parse(dateStr, format:"dd MM")
        let dateFmt           = NSDateFormatter()
        dateFmt.dateFormat    = "yyyy-MM-dd' 'HH:mm:ss"//
        
        let dateStr = dateFmt.stringFromDate(dateNSDate)
        return dateStr
    }
    
    class func CalculateUsedTime(dateStart:NSDate, dateEnd: NSDate? = nil) -> String {//, dateEnd: NSData? = nil
        //http://stackoverflow.com/a/24755958/2643285
        
        let start       = dateStart // <<<<<<<<<< Start time
        //let enddt   = dateEnd // <<<<<<<<<<   end time
        let enddt       = dateEnd != nil ? dateEnd! as NSDate : getCurrentDate()
        
        //
        let calendar    = NSCalendar.currentCalendar()
        
        
        let datecomponenets = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: start, toDate: enddt, options: [])
        
        let year    = datecomponenets.year
        let month   = datecomponenets.month
        let day     = datecomponenets.day
        let hour    = datecomponenets.hour
        let minute  = datecomponenets.minute
        let second  = datecomponenets.second
        
        var timeIntervalString:String = ""
        if year > 0 {
            timeIntervalString = String(year) + " years"
        }else if month > 0 {
            timeIntervalString = String(month) + " months"
        }else if day > 0 {
            timeIntervalString = String(day) + " days"
            //detail someone..
//            if day == 1 {
//                timeIntervalString = "yesterday"
//                //            else if day == 2 {
//                //              timeIntervalString = "day before yesterday"
//            }
        }else if hour > 0 {
            timeIntervalString = String(hour) + " hours"
        }else if minute > 0 {
            timeIntervalString = String(minute) + " minutes"
        }else if second > 0 {
            timeIntervalString = String(second) + " seconds"
        }else{
            timeIntervalString = ""
        }
        
        
        return String(timeIntervalString);
    }
    
    class func getCurrentDate() -> NSDate {
        let date        = NSDate()
        let calendar    = NSCalendar.currentCalendar()
        //let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: date)
        
        let year    = components.year
        let month   = components.month
        let day     = components.day
        let hour    = components.hour
        let minutes = components.minute
        let seconds = components.second
        
        return from(year:year, month:month, day:day, hour:hour, minute:minutes, second:seconds)
    }
    
}

//}

// MARK: Call Example
//var date = Date.parse("2014-05-20 22:05:54")
//var date = Date.parseForMainTableView("2014-05-20 22:05:54")
//var dΩate = Date.from(year: 2014, month: 05, day: 20, hour:0, minute:0, second:0)
//var currentDate = Date.getCurrentDate()
