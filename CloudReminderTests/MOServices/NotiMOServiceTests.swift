//
//  NotiMOServiceTests.swift
//  CloudReminderTests
//
//  Created by 9oya on 2020/08/01.
//  Copyright © 2020 Dymm. All rights reserved.
//

@testable import CloudReminder
import XCTest
import CoreData

class NotiMOServiceTests: XCTestCase {
    
    var mockNotiMOService: MockNotiMOService!
    var mockNotiGroupMOService: MockNotiGroupMOService!
    var testCoreDataStack: CoreDataStack!

    override func setUpWithError() throws {
        testCoreDataStack = TestCoreDataStack()
        mockNotiMOService = MockNotiMOService(coreDataStack: testCoreDataStack)
        mockNotiGroupMOService = MockNotiGroupMOService(coreDataStack: testCoreDataStack)
    }

    override func tearDownWithError() throws {
        mockNotiGroupMOService = nil
        mockNotiMOService = nil
        testCoreDataStack = nil
    }
    
    func testNotiMO_create_isRestulValueMatch() {
        // given
        let id = UUID()
        let weekCode = WeekCode.Sun
        let isOn = true
        let notiGroupMO = mockNotiGroupMOService.createNotiGroupMO(id: UUID(), hour: 7, minute: 30, isOn: true, title: "TestTitle", content: "It's time for breakfast")
        
        // when
        let newNotiMO = mockNotiMOService.createNotiMO(notiGroupMO: notiGroupMO, id: id, weekCode: weekCode, isOn: isOn)
        
        // than
        XCTAssertTrue(newNotiMO.id == id)
        XCTAssertTrue(newNotiMO.weekCode == weekCode.rawValue)
        XCTAssertTrue(newNotiMO.isOn == isOn)
        XCTAssertTrue(newNotiMO.notiGroupMO == notiGroupMO)
    }
    
    func testNotiMO_get_isResultRight() {
        // given
        let id = UUID()
        let weekCode = WeekCode.Sun
        let isOn = true
        let notiGroupMO = mockNotiGroupMOService.createNotiGroupMO(id: UUID(), hour: 7, minute: 30, isOn: true, title: "TestTitle", content: "It's time for breakfast")
        _ = mockNotiMOService.createNotiMO(notiGroupMO: notiGroupMO, id: id, weekCode: weekCode, isOn: isOn)
        
        // when
        let notiMO = mockNotiMOService.getNotiMOById(id: id)
        
        // than
        XCTAssertNotNil(notiMO)
        XCTAssertEqual(notiMO?.id, id)
        XCTAssertEqual(notiMO?.weekCode, Int16(weekCode.rawValue))
        XCTAssertEqual(notiMO?.isOn, isOn)
    }
    
    func testNotiMO_getAll_count() {
        // given
        let id = UUID()
        let isOn = true
        let notiGroupMO = mockNotiGroupMOService.createNotiGroupMO(id: UUID(), hour: 7, minute: 30, isOn: true, title: "TestTitle", content: "It's time for breakfast")
        _ = mockNotiMOService.createNotiMO(notiGroupMO: notiGroupMO, id: id, weekCode: WeekCode.Sun, isOn: isOn)
        _ = mockNotiMOService.createNotiMO(notiGroupMO: notiGroupMO, id: id, weekCode: WeekCode.Mon, isOn: isOn)
        _ = mockNotiMOService.createNotiMO(notiGroupMO: notiGroupMO, id: id, weekCode: WeekCode.Tue, isOn: isOn)
        _ = mockNotiMOService.createNotiMO(notiGroupMO: notiGroupMO, id: id, weekCode: WeekCode.Wed, isOn: isOn)
        
        // when
        let notiMOArr = mockNotiMOService.getAllNotiMOs()
        
        // than
        XCTAssertEqual(4, notiMOArr?.count)
    }
    
    func testNotiMO_delete_isGivenIdObjDeleted() {
        // given
        let id = UUID()
        let weekCode = WeekCode.Sun
        let isOn = true
        let notiGroupMO = mockNotiGroupMOService.createNotiGroupMO(id: UUID(), hour: 7, minute: 30, isOn: true, title: "TestTitle", content: "It's time for breakfast")
        _ = mockNotiMOService.createNotiMO(notiGroupMO: notiGroupMO, id: id, weekCode: weekCode, isOn: isOn)
        _ = mockNotiMOService.createNotiMO(notiGroupMO: notiGroupMO, id: UUID(), weekCode: WeekCode.Mon, isOn: false)
        _ = mockNotiMOService.createNotiMO(notiGroupMO: notiGroupMO, id: UUID(), weekCode: WeekCode.Thu, isOn: false)
        
        // when
        if !mockNotiMOService.deleteNotiMOById(id: id) {
            XCTFail()
        }
        
        // than
        XCTAssertNil(mockNotiMOService.getNotiMOById(id: id))
    }
    
    func testNotiMO_update_isGivenIdObjUpdated() {
        // given
        let id = UUID()
        let weekCode = WeekCode.Sun
        let notiGroupMO = mockNotiGroupMOService.createNotiGroupMO(id: UUID(), hour: 7, minute: 30, isOn: true, title: "TestTitle", content: "It's time for breakfast")
        _ = mockNotiMOService.createNotiMO(notiGroupMO: notiGroupMO, id: id, weekCode: weekCode, isOn: true)
        
        // when
        let isOn = false
        let notiMO = mockNotiMOService.updateNotiMO(id: id, isOn: isOn)
        
        // than
        XCTAssertEqual(notiMO?.isOn, isOn)
    }
}

class MockNotiMOService: NotiMOServiceProtocol {
    // MARK: Properties
    static let shared = NotiMOService(coreDataStack: CoreDataStack())
    var managedObjContext: NSManagedObjectContext
    var coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.managedObjContext = coreDataStack.mainContext
        self.coreDataStack = coreDataStack
    }
    
    func convertNotiMOArrToDaysOfWeekDict(notiMOArr: [NotiMO]) -> [Int: Bool] {
        var daysOfWeekDict = [1: false, 2: false, 3: false, 4: false, 5: false, 6: false, 7: false]
        for notiMO in notiMOArr {
            daysOfWeekDict[Int(notiMO.weekCode)]?.toggle()
        }
        return daysOfWeekDict
    }
    
    // MARK: CREATE Services
    func createNotiMO(notiGroupMO: NotiGroupMO, id: UUID, weekCode: WeekCode, isOn: Bool) -> NotiMO {
        let newNotiMO = NotiMO(context: managedObjContext)
        newNotiMO.notiGroupMO = notiGroupMO
        newNotiMO.id = id
        newNotiMO.weekCode = Int16(weekCode.rawValue)
        newNotiMO.isOn = isOn
        
        notiGroupMO.addToNotiMOs(newNotiMO)
        
        managedObjContext.perform {
            self.coreDataStack.saveContext(self.managedObjContext)
        }
        return newNotiMO
    }
    
    // MARK: GET Services
    func getNotiMOById(id: UUID) -> NotiMO? {
        let fetchRequest: NSFetchRequest<NotiMO> = NotiMO.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(NotiMO.id), id])
        
        let notiMOArr: [NotiMO]?
        do {
            notiMOArr = try managedObjContext.fetch(fetchRequest)
        } catch {
            return nil
        }
        return notiMOArr?.first ?? nil
    }
    
    func getAllNotiMOs() -> [NotiMO]? {
        let fetchRequest: NSFetchRequest<NotiMO> = NotiMO.fetchRequest()
        
        let notiMOArr: [NotiMO]?
        do {
            notiMOArr = try managedObjContext.fetch(fetchRequest)
        } catch {
            return nil
        }
        return notiMOArr ?? nil
    }
    
    // MARK: DELETE Services
    func deleteNotiMOById(id: UUID) -> Bool {
        guard let notiMO = getNotiMOById(id: id) else {
            return false
        }
        managedObjContext.delete(notiMO)
        coreDataStack.saveContext(managedObjContext)
        return true
    }
    
    // MARK: UPDATE Services
    func updateNotiMO(id: UUID, isOn: Bool) -> NotiMO? {
        guard let notiMO = getNotiMOById(id: id) else {
            return nil
        }
        notiMO.isOn = isOn
        coreDataStack.saveContext(managedObjContext)
        return notiMO
    }
}
