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
}
