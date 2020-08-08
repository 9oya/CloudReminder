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
}
