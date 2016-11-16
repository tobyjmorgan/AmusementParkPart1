//
//  DateHelper.swift
//  AmusementParkPart1
//
//  Created by redBred LLC on 11/16/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import Foundation

class DateHelper {
    
    static func getTimeInterval(year: Int) -> TimeInterval {
        return TimeInterval(60*60*24*365.2422*Double(year))
    }
    
    static func getDate(year: Int, month: Int, Day: Int) -> Date? {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = Day
        
        return calendar.date(from: components)
    }
    
    static func getPastDate(interval: TimeInterval) -> Date {
        
        return Date().addingTimeInterval(-1*interval)
    }
}
