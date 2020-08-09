//
//  DateHelper.swift
//  CloudReminder
//
//  Created by 9oya on 2020/08/08.
//  Copyright © 2020 Dymm. All rights reserved.
//

import Foundation

final class DateHelper {
    static let shared = DateHelper()
    
    func convertDateToTimeTxt(date: Date? = nil, hour: Int? = 0, minute: Int? = 0) -> String {
        var _hour: Int = 0
        var _minute: Int = 0
        if let _date = date {
            _hour = Calendar.current.component(.hour, from: _date)
            _minute = Calendar.current.component(.minute, from: _date)
        } else if hour! > 0 {
            _hour = hour!
            _minute = minute!
        }
        
        var hourTxt = ""
        var minuteTxt = ""
        var am_pm: String = "AM"
        
        if _hour >= 12 {
            am_pm = "PM"
            if _hour == 12 {
                hourTxt = "\(_hour)"
            } else {
                _hour -= 12
                hourTxt = "0\(_hour)"
            }
        } else {
            hourTxt = "\(_hour)"
        }
        
        if _minute < 10 {
            minuteTxt = "0\(_minute)"
        } else {
            minuteTxt = "\(_minute)"
        }
        
        return "\(am_pm) \(hourTxt) : \(minuteTxt)"
    }
    
    func convertDateToHourAndMinute(date: Date) -> (Int, Int) {
        let hour = Calendar.current.component(.hour, from: date)
        let minute = Calendar.current.component(.minute, from: date)
        return (hour, minute)
    }
    
    func convertDaysOfWeekDictToText(daysOfWeekDict: [Int: Bool]) -> String {
        var daysOfWeekTxt = ""
        if daysOfWeekDict[1]! {
            daysOfWeekTxt += "Sun/"
        }
        if daysOfWeekDict[2]! {
            daysOfWeekTxt += "Mon/"
        }
        if daysOfWeekDict[3]! {
            daysOfWeekTxt += "Tue/"
        }
        if daysOfWeekDict[4]! {
            daysOfWeekTxt += "Wed/"
        }
        if daysOfWeekDict[5]! {
            daysOfWeekTxt += "Thu/"
        }
        if daysOfWeekDict[6]! {
            daysOfWeekTxt += "Fri/"
        }
        if daysOfWeekDict[7]! {
            daysOfWeekTxt += "Sat"
        }
        
        var result = ""
        let daysOfWeekTxtArr = daysOfWeekTxt.split(separator: "/")
        for (idx, dayOfWeek) in daysOfWeekTxtArr.enumerated() {
            if idx + 1 >= daysOfWeekTxtArr.count {
                result += "\(dayOfWeek)"
            } else {
                result += "\(dayOfWeek)·"
            }
        }
        
        if result == "Sun·Mon·Tue·Wed·Thu·Fri·Sat" {
            result = "Everyday"
        } else if result == "Mon·Tue·Wed·Thu·Fri" {
            result = "Weekdays"
        } else if result == "Sun·Sat" {
            result = "Weekend"
        } else {
            return result
        }
        return result
    }
}
