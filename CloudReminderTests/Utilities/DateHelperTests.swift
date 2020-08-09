//
//  DateHelperTests.swift
//  CloudReminderTests
//
//  Created by 9oya on 2020/08/08.
//  Copyright © 2020 Dymm. All rights reserved.
//

import XCTest
import Foundation

class DateHelperTests: XCTestCase {
    
    var mockDateHelper: MockDateHelper!

    override func setUpWithError() throws {
        mockDateHelper = MockDateHelper()
    }

    override func tearDownWithError() throws {
        mockDateHelper = nil
    }
    
    func testDateHelper_convertDateToTimeTxt_result() {
        // given
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let date = formatter.date(from: "13:30")
        
        // when
        let result = mockDateHelper.convertDateToTimeTxt(date: date, hour: nil, minute: nil)
        
        // than
        XCTAssertEqual("PM 01 : 30", result)
    }
    
    func testDateHelper_convertHourMinuteToTimeTxt_result() {
        // given
        let hour = 13
        let minute = 30
        
        // when
        let result = mockDateHelper.convertDateToTimeTxt(date: nil, hour: hour, minute: minute)
        
        // than
        XCTAssertEqual("PM 01 : 30", result)
    }
    
    func testDateHelper_convertDateToHourAndMinute_result() {
        // given
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        let date = formatter.date(from: "08-09-2020 12:35")
        
        // when
        let (hour, minute) = mockDateHelper.convertDateToHourAndMinute(date: date!)
        
        // than
        XCTAssertEqual(hour, 12)
        XCTAssertEqual(minute, 35)
    }
    
    func testDateHelper_convertDaysOfWeekDictToText_result() {
        // given
        let daysOfWeekDict1 = [1: true, 2: true, 3: true, 4: true, 5: true, 6: true, 7: true]
        let daysOfWeekDict2 = [1: false, 2: true, 3: true, 4: true, 5: true, 6: true, 7: false]
        let daysOfWeekDict3 = [1: true, 2: false, 3: false, 4: false, 5: false, 6: false, 7: true]
        let daysOfWeekDict4 = [1: false, 2: true, 3: true, 4: true, 5: true, 6: true, 7: true]
        
        // when
        let daysOfWeekTxt1 = mockDateHelper.convertDaysOfWeekDictToText(daysOfWeekDict: daysOfWeekDict1)
        let daysOfWeekTxt2 = mockDateHelper.convertDaysOfWeekDictToText(daysOfWeekDict: daysOfWeekDict2)
        let daysOfWeekTxt3 = mockDateHelper.convertDaysOfWeekDictToText(daysOfWeekDict: daysOfWeekDict3)
        let daysOfWeekTxt4 = mockDateHelper.convertDaysOfWeekDictToText(daysOfWeekDict: daysOfWeekDict4)
        
        // than
        XCTAssertEqual(daysOfWeekTxt1, "Everyday")
        XCTAssertEqual(daysOfWeekTxt2, "Weekdays")
        XCTAssertEqual(daysOfWeekTxt3, "Weekend")
        XCTAssertEqual(daysOfWeekTxt4, "Mon·Tue·Wed·Thu·Fri·Sat")
    }
}

class MockDateHelper {
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
