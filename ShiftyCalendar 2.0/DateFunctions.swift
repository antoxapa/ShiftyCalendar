//
//  DateFunctions.swift
//  ShiftyCalendar 2.0
//
//  Created by Антон Потапчик on 9/13/19.
//  Copyright © 2019 TonyPo Production. All rights reserved.
//

import Foundation

public struct Today {
    public static let todayDate = Date()
}

func getDateFrom(year: Int, month: Int, day: Int) -> Date? {
    let dateComponents = DateComponents(year: year, month: month, day: day)
    let calendar = Calendar.current
    if let date = calendar.date(from: dateComponents) {
        return date
    }
    return nil
}
func getYearAndMonth(year: Int, month: Int) -> Date? {
    let dateComponents = DateComponents(year: year, month: month)
    let calendar = Calendar.current
    if let date = calendar.date(from: dateComponents){
        return date
    }
    return nil
}

func getNumberOfDaysInMonth(year: Int, month: Int) -> Int {
    let dateComponents = DateComponents(year: year, month: month)
    let calendar = Calendar.current
    if let date = calendar.date(from: dateComponents), let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: date) {
        return numberOfDaysInMonth.count
    }
    return 0
}


public enum WeekStartDay {
    case monday
    case sunday
}

public func getDayOfWeek(year: Int, month: Int) -> Int {
    let dateComponents = DateComponents(year: year, month: month)
    let calendar = Calendar.current
    if let date = calendar.date(from: dateComponents) {
        let day = calendar.component(.weekday, from: date)
        return day
    }
    return 0
}

public func getSkipCount(_ weekDayNo: Int, startDay: WeekStartDay) -> Int {
    switch startDay {
    case .monday:
        return getCountForMonday(weekDayNo)
    case .sunday:
        return getCountForSunday(weekDayNo)
    }
}

func getCountForMonday(_ weekDayNo: Int) -> Int {
    switch weekDayNo {
    case 1:
        return 6
    case 2:
        return 0
    case 3:
        return 1
    case 4:
        return 2
    case 5:
        return 3
    case 6:
        return 4
    case 7:
        return 5
    default:
        return 0
    }
}
func getCountForSunday(_ weekDayNo: Int) -> Int {
    switch weekDayNo {
    case 1:
        return 0
    case 2:
        return 1
    case 3:
        return 2
    case 4:
        return 3
    case 5:
        return 4
    case 6:
        return 5
    case 7:
        return 6
    default:
        return 0
    }
}


// MARK: - Date extension
extension Date {
    func getDateAfter(year: Int, month: Int) -> Date {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        if let date = calendar.date(byAdding: dateComponents, to: self) {
            return date
        }
        return Today.todayDate
    }
    
    func getMonth() -> (year: Int, month: Int, name: String) {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLL"
        let monthName = dateFormatter.string(from: self)
        return (year, month, monthName)
    }
    
    func getEventInfo() -> (year: Int, month: Int, day: Int) {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        return (year, month, day)
    }
    
//    func getWeekend(year: Int, month: Int, day: Int) {
//        let calendar = Calendar.current
//        let currentWeekDay = getDateFrom(year: year, month: month, day: day)
//        if calendar.wee {
//            print("weekend!")
//        } else {
//            print("not weekend")
//        }
//    }
    
    func isSame(_ date: Date?) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyy"
        guard let date = date else { return false }
        if formatter.string(from: self) == formatter.string(from: date) {
            return true
        }
        return false
    }
}
