//
//  NotiDetailNotiDetailPresenterTests.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

@testable import CloudReminder
import XCTest

class NotiDetailPresenterTest: XCTestCase {
    
    var mockInteractor: MockInteractor!
    var mockDateHelper: MockDateHelper!
    var coreDataStack: CoreDataStack!
    var mockNotiGroupMOService: MockNotiGroupMOService!

    override func setUp() {
        super.setUp()
        mockInteractor = MockInteractor()
        mockDateHelper = MockDateHelper()
        coreDataStack = TestCoreDataStack()
        mockNotiGroupMOService = MockNotiGroupMOService(coreDataStack: coreDataStack)
    }

    override func tearDown() {
        mockNotiGroupMOService = nil
        coreDataStack = nil
        mockDateHelper = nil
        mockInteractor = nil
        super.tearDown()
    }
    
    func testInteractorInput_configureEmptyNotiDetail_result() {
        // given
        let guideKey = "guide"
        let contentKey = "content"
        
        // when
        let detailDictArr = mockInteractor.configureEmptyNotiDetail()
        
        // than
        XCTAssertTrue((detailDictArr[0][guideKey] != nil), "Title")
        XCTAssertTrue((detailDictArr[1][guideKey] != nil), "Content")
        XCTAssertTrue((detailDictArr[2][guideKey] != nil), "Time")
        XCTAssertNotNil((detailDictArr[2][contentKey]))
        XCTAssertTrue((detailDictArr[3][guideKey] != nil), "Repeat")
        XCTAssertTrue((detailDictArr[3][contentKey] != nil), "Everyday")
    }
    
    func testInteractorInput_configureSelectedNotiDetail_result() {
        // given
        let guideKey = "guide"
        let contentKey = "content"
        
        let id = UUID()
        let hour = 7
        let minute = 30
        let isOn = true
        let title = "TestTitle"
        let content = "It's lunch time~!!"
        let notiGroupMO = mockNotiGroupMOService.createNotiGroupMO(id: id, hour: hour, minute: minute, isOn: isOn, title: title, content: content)
        
        // when
        let detailDictArr = mockInteractor.configureSelectedNotiDetail(notiGroupMO: notiGroupMO)
        
        // than
        XCTAssertTrue((detailDictArr[0][guideKey] != nil), "Title")
        XCTAssertTrue((detailDictArr[1][guideKey] != nil), "Content")
        XCTAssertTrue((detailDictArr[2][guideKey] != nil), "Time")
        XCTAssertNotNil((detailDictArr[2][contentKey]))
        XCTAssertTrue((detailDictArr[3][guideKey] != nil), "Repeat")
        XCTAssertTrue((detailDictArr[3][contentKey] != nil), "Everyday")
    }
    
    func testeInteractor_createNotification_result() {
        // given
        let hour = 7
        let minute = 30
        let isOn = true
        let title = "TestTitle"
        let content = "It's lunch time~!!"
        let daysOfWeekDict = [1: true, 2: true, 3: true, 4: true, 5: true, 6: true, 7: false]
        
        // when
        let notiGroupMO = mockInteractor.createNotification(title: title, content: content, hour: hour, minute: minute, daysOfWeekDict: daysOfWeekDict, isOn: isOn)
        
        // than
        XCTAssertNotNil(notiGroupMO)
        XCTAssertEqual(hour, Int(notiGroupMO.hour))
        XCTAssertEqual(minute, Int(notiGroupMO.minute))
        XCTAssertEqual(isOn, notiGroupMO.isOn)
        XCTAssertEqual(title, notiGroupMO.title)
        XCTAssertEqual(content, notiGroupMO.content)
        XCTAssertEqual(6, notiGroupMO.notiMOs?.count)
    }

    class MockInteractor: NotiDetailInteractorInput {
        func configureEmptyNotiDetail() -> [[String: String]] {
            var detailDictArr = [[String: String]]()
            let daysOfWeekDict = [1: true, 2: true, 3: true, 4: true, 5: true, 6: true, 7: true]
            detailDictArr.append([
                "guide": "Title",
                "content": "CloudReminer"
            ])
            detailDictArr.append([
                "guide": "Content",
                "content": ""
            ])
            detailDictArr.append([
                "guide": "Time",
                "content": DateHelper.shared.convertDateToTimeTxt(date: Date(), hour: nil, minute: nil)
            ])
            detailDictArr.append([
                "guide": "Repeat",
                "content": convertDaysOfWeekDictToText(daysOfWeekDict: daysOfWeekDict)
            ])
            return detailDictArr
        }
        
        func configureSelectedNotiDetail(notiGroupMO: NotiGroupMO) -> [[String: String]] {
            var detailDictArr = [[String: String]]()
            let notiGroupViewModel = NotiGroupViewModel(notiGroupMO: notiGroupMO)
            let notiMOArr = notiGroupMO.notiMOs!.allObjects as! [NotiMO]
            detailDictArr.append([
                "guide": "Title",
                "content": notiGroupViewModel.title
            ])
            detailDictArr.append([
                "guide": "Content",
                "content": notiGroupViewModel.content
            ])
            detailDictArr.append([
                "guide": "Time",
                "content": notiGroupViewModel.time
            ])
            detailDictArr.append([
                "guide": "Repeat",
                "content": convertDaysOfWeekDictToText(daysOfWeekDict: convertNotiMOArrToDaysOfWeekDict(notiMOArr: notiMOArr))
            ])
            return detailDictArr
        }
        
        func numberOfRows() -> Int {
            return configureEmptyNotiDetail().count
        }
        
        func detailDictArrAt(notiGroupMO: NotiGroupMO, indexPath: IndexPath) -> [String: String] {
            return configureSelectedNotiDetail(notiGroupMO: notiGroupMO)[indexPath.row]
        }
        
        func createNotification(title: String, content: String, hour: Int, minute: Int, daysOfWeekDict: [Int: Bool], isOn: Bool) -> NotiGroupMO {
            // Create a CoreData NotiGroupMO
            let notiGroupMO = NotiGroupMOService.shared.createNotiGroupMO(id: UUID(), hour: hour, minute: minute, isOn: isOn, title: title, content: content)
            
            if !isOn {
                return notiGroupMO
            }
            
            // Create CoreData NotiMOs
            let notiMOService = NotiMOService(coreDataStack: NotiGroupMOService.shared.coreDataStack)
            var notiMOArr = [NotiMO]()
            for (weekCode, isSelected) in daysOfWeekDict {
                if isSelected {
                    let notiMO = notiMOService.createNotiMO(notiGroupMO: notiGroupMO, id: UUID(), weekCode: WeekCode(rawValue: weekCode)!, isOn: isSelected)
                    notiMOArr.append(notiMO)
                } else {
                    // do nothing...
                }
            }
            
            // Schedule local notifications
            let localNotiScheduler = LocalNotiScheduler()
            if var _notiMOArr = notiMOService.getAllNotiMOs() {
                _notiMOArr += notiMOArr
                localNotiScheduler.notiMOArr = _notiMOArr
            } else {
                localNotiScheduler.notiMOArr = notiMOArr
            }
            localNotiScheduler.schedule()
            return notiGroupMO
        }
        
        private func convertNotiMOArrToDaysOfWeekDict(notiMOArr: [NotiMO]) -> [Int: Bool] {
            var daysOfWeekDict = [1: false, 2: false, 3: false, 4: false, 5: false, 6: false, 7: false]
            for notiMO in notiMOArr {
                daysOfWeekDict[Int(notiMO.weekCode)]?.toggle()
            }
            return daysOfWeekDict
        }
        
        private func convertDaysOfWeekDictToText(daysOfWeekDict: [Int: Bool]) -> String {
            var daysOfWeekTxt = ""
            if daysOfWeekDict[1]! {
                daysOfWeekTxt += "Sun"
            }
            if daysOfWeekDict[2]! {
                daysOfWeekTxt += "Mon"
            }
            if daysOfWeekDict[3]! {
                daysOfWeekTxt += "Tue"
            }
            if daysOfWeekDict[4]! {
                daysOfWeekTxt += "Wed"
            }
            if daysOfWeekDict[5]! {
                daysOfWeekTxt += "Thu"
            }
            if daysOfWeekDict[6]! {
                daysOfWeekTxt += "Fri"
            }
            if daysOfWeekDict[7]! {
                daysOfWeekTxt += "Sat"
            }
            
            var result = ""
            for (idx, dayOfWeek) in daysOfWeekTxt.enumerated() {
                if idx + 1 >= daysOfWeekTxt.count {
                    result += "\(dayOfWeek)"
                } else {
                    result += "\(dayOfWeek)/"
                }
            }
            
            if result == "Sun/Mon/Tue/Wed/Thu/Fri/Sat" {
                result = "Everyday"
            } else if result == "Mon/Tue/Wed/Thu/Fri" {
                result = "Weekdays"
            } else if result == "Sun/Sat" {
                result = "Weekend"
            } else {
                return result
            }
            return result
        }
    }

    class MockRouter: NotiDetailRouterInput {

    }

    class MockViewController: NotiDetailViewInput {

        func setupInitialState() {

        }
    }
}
