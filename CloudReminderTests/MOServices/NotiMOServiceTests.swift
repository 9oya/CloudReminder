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
    var testCoreDataStack: CoreDataStack!

    override func setUpWithError() throws {
        testCoreDataStack = TestCoreDataStack()
        mockNotiMOService = MockNotiMOService(coreDataStack: testCoreDataStack)
    }

    override func tearDownWithError() throws {
        mockNotiMOService = nil
        testCoreDataStack = nil
    }
    
    func testNotiMO_create_isRestulValueMatch() {
        // given
        let notiGroupMO = mockNotiGroupMOService.createNotiGroupMO(id: UUID(), hour: 7, minute: 30, isOn: true, content: content1)
        let id = UUID()
        let weekCode = WeekCode.Sun
        let body = "It's time for breakfast"
        let isOn = true
        
        // when
        let newNotiMO = mockNotiMOService.createNotiMO(notiGroupMO: notiGroupMO, id: id, weekCode: weekCode, body: body, isOn: isOn)
        
        // than
        XCTAssertTrue(newNotiMO.id == id)
        XCTAssertTrue(newNotiMO.weekCode == weekCode)
        XCTAssertTrue(newNotiMO.body == body)
        XCTAssertTrue(newNotiMO.isOn == isOn)
        XCTAssertTrue(newNotiMO.notiGroupMO == notiGroupMO)
    }
    
    func testNotiMO_get_isResultRight() {
        // given
        
        // when
        
        // than
    }
    
    func testNotiMO_delete_isGivenIdObjDeleted() {
        // given
        
        // when
        
        // than
    }
    
    func testNotiMO_update_isGivenIdObjUpdated() {
        // given
        
        // when
        
        // than
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
    
    // MARK: CREATE Services
    func createNotiMO(notiGroupMO: NotiGroupMO, id: UUID, weekCode: WeekCode, body: String, isOn: Bool) -> NotiMO {
        let newNotiMO = NotiMO(context: managedObjContext)
        newNotiMO.notiGroupMO = notiGroupMO
        newNotiMO.id = id
        newNotiMO.weekCode = weekCode.rawValue
        newNotiMO.body = body
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
