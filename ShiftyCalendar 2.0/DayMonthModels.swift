//
//  DayMonthModels.swift
//  ShiftyCalendar 2.0
//
//  Created by Антон Потапчик on 9/13/19.
//  Copyright © 2019 TonyPo Production. All rights reserved.
//

import Foundation

class CalendarMonth {
    var monthName: String!
    var monthNumber: Int!
    var year: Int!
    var days: [CalendarDay] = [CalendarDay]()
    var skipCount: Int!

    
    init(year: Int, monthNumber: Int, monthName: String) {
        self.year = year
        self.monthNumber = monthNumber
        self.monthName = monthName
        
        let weekDay = getMonthWeekDay(year: year, month: monthNumber)
        let skipCount = getSkipCount(weekDay, startDay: .monday)
        self.skipCount = skipCount
        
        let totalDaysInMonth = getNumberOfDaysInMonth(year: year, month: monthNumber)
        self.days = createDaysArray(from: totalDaysInMonth, month: monthNumber, year: year)
        
    }
    
    
    func createDaysArray(from days: Int, month: Int, year: Int) -> [CalendarDay] {
        var dayArray = [CalendarDay]()
        for i in 1...days {
            dayArray.append(CalendarDay(day: i))
        }
        return dayArray
    }
}

class CalendarDay {
    var day: Int!
    init(day: Int) {
        self.day = day
    }
}
