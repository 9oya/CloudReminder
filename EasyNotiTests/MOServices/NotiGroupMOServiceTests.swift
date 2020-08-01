//
//  NotiGroupMOServiceTests.swift
//  EasyNotiTests
//
//  Created by 9oya on 2020/08/01.
//  Copyright © 2020 Dymm. All rights reserved.
//

@testable import EasyNoti
import XCTest
import CoreData

class NotiGroupMOServiceTests: XCTestCase {
    
    var mockNotiGroupMOService: MockNotiGroupMOService!
    var testCoreDateStack: CoreDataStack!

    override func setUpWithError() throws {
        testCoreDateStack = TestCoreDataStack()
        mockNotiGroupMOService = MockNotiGroupMOService(coreDataStack: testCoreDateStack)
    }

    override func tearDownWithError() throws {
        mockNotiGroupMOService = nil
        testCoreDateStack = nil
    }
    
    func testNotiGroupMO_create_isResultValueMatch() {
        // given
        let id = UUID()
        let hour = 7
        let minute = 30
        let isOn = true
        let content = "It's lunch time~!!"
        
        // when
        let newNotiGroupMO = mockNotiGroupMOService.createNotiGroupMO(id: id, hour: hour, minute: minute, isOn: isOn, content: content)
        
        // than
        XCTAssertTrue(newNotiGroupMO.id == id)
        XCTAssertTrue(newNotiGroupMO.hour == hour)
        XCTAssertTrue(newNotiGroupMO.minute == minute)
        XCTAssertTrue(newNotiGroupMO.isOn == isOn)
        XCTAssertTrue(newNotiGroupMO.content == content)
    }
    
    func testNotiGrouMO_get_isResultObjRight() {
        // given
        let id = UUID()
        let content = "It's lunch time~!!"
        _ = mockNotiGroupMOService.createNotiGroupMO(id: id, hour: 7, minute: 30, isOn: true, content: content)
        
        // when
        let notiGroupMO = mockNotiGroupMOService.getNotifGroupMOById(id: id)
        
        // than
        XCTAssertNotNil(notiGroupMO)
        XCTAssertEqual(notiGroupMO?.id, id)
        XCTAssertEqual(notiGroupMO?.content, content)
    }
    
    func testNotiGroupMO_getFRC_isPerformResultSorted() {
        // given
        let content1 = "It's time for breakfast"
        let content2 = "It's time for lunch"
        let content3 = "It's time for dinner"
        _ = mockNotiGroupMOService.createNotiGroupMO(id: UUID(), hour: 7, minute: 30, isOn: true, content: content1)
        _ = mockNotiGroupMOService.createNotiGroupMO(id: UUID(), hour: 12, minute: 30, isOn: true, content: content2)
        _ = mockNotiGroupMOService.createNotiGroupMO(id: UUID(), hour: 18, minute: 25, isOn: true, content: content3)
        
        let frc: NSFetchedResultsController<NotiGroupMO> = mockNotiGroupMOService.getNotiGroupMOFRC()
        
        // when
        do {
            try frc.performFetch()
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
            XCTFail()
        }
        
        // than
        let rows = frc.sections?[0].numberOfObjects
        XCTAssertEqual(rows, 3)
        
        let indexPath = IndexPath(row: 0, section: 0)
        XCTAssertEqual(frc.object(at: indexPath).content, content1)
    }
    
    func testNotiGroupMO_delete_isGivenIdObjDeleted() {
        // given
        let id = UUID()
        let content = "It's lunch time~!!"
        _ = mockNotiGroupMOService.createNotiGroupMO(id: id, hour: 7, minute: 30, isOn: true, content: content)
        _ = mockNotiGroupMOService.createNotiGroupMO(id: UUID(), hour: 12, minute: 30, isOn: true, content: content)
        _ = mockNotiGroupMOService.createNotiGroupMO(id: UUID(), hour: 18, minute: 25, isOn: true, content: content)
        
        // when
        if !mockNotiGroupMOService.deleteNotifGroupMOById(id: id) {
            XCTFail()
        }
        
        // than
        XCTAssertNil(mockNotiGroupMOService.getNotifGroupMOById(id: id))
    }
    
    func testNotiGroupMO_update_isGivenIdObjUpdated() {
        // given
        let id = UUID()
        let content = "It's time for breakfast"
        _ = mockNotiGroupMOService.createNotiGroupMO(id: id, hour: 7, minute: 30, isOn: true, content: content)
        
        // when
        let newHour = 12
        let newMinute = 30
        let isOn = false
        let newContent = "It's time for lunch"
        let notifGroupMO = mockNotiGroupMOService.updateNotiGroupMO(id: id, hour: newHour, minute: newMinute, isOn: isOn, content: newContent)
        
        // than
        XCTAssertEqual(notifGroupMO?.hour, Int16(newHour))
        XCTAssertEqual(notifGroupMO?.minute, Int16(newMinute))
        XCTAssertEqual(notifGroupMO?.isOn, isOn)
        XCTAssertEqual(notifGroupMO?.content, newContent)
    }
}

class MockNotiGroupMOService: NotiGroupMOServiceProtocol {
    // MARK: Properties
    static let shared = NotiGroupMOService(coreDataStack: CoreDataStack())
    var managedObjContext: NSManagedObjectContext
    var coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.managedObjContext = coreDataStack.mainContext
        self.coreDataStack = coreDataStack
    }
    
    // MARK: CREATE Services
    func createNotiGroupMO(id: UUID, hour: Int, minute: Int, isOn: Bool, content: String) -> NotiGroupMO {
        let newNotiGroupMO = NotiGroupMO(context: managedObjContext)
        newNotiGroupMO.id = id
        newNotiGroupMO.hour = Int16(hour)
        newNotiGroupMO.minute = Int16(minute)
        newNotiGroupMO.isOn = isOn
        newNotiGroupMO.content = content
        
        managedObjContext.perform {
            self.coreDataStack.saveContext(self.managedObjContext)
        }
        
        return newNotiGroupMO
    }
    
    // MARK: GET Services
    func getNotifGroupMOById(id: UUID) -> NotiGroupMO? {
        let fetchReqeust: NSFetchRequest<NotiGroupMO> = NotiGroupMO.fetchRequest()
        fetchReqeust.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(NotiGroupMO.id), id])
        let notiGroups: [NotiGroupMO]?
        do {
            notiGroups = try managedObjContext.fetch(fetchReqeust)
        } catch {
            return nil
        }
        return notiGroups?.first
    }
    
    func getNotiGroupMOFRC() -> NSFetchedResultsController<NotiGroupMO> {
        let fetchReqeust: NSFetchRequest<NotiGroupMO> = NotiGroupMO.fetchRequest()
        let hourSort = NSSortDescriptor(key: #keyPath(NotiGroupMO.hour), ascending: true)
        let minuteSort = NSSortDescriptor(key: #keyPath(NotiGroupMO.minute), ascending: true)
        let contentSort = NSSortDescriptor(key: #keyPath(NotiGroupMO.content), ascending: true)
        
        fetchReqeust.sortDescriptors = [hourSort, minuteSort, contentSort]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchReqeust, managedObjectContext: managedObjContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }
    
    // MARK: DELETE Services
    func deleteNotifGroupMOById(id: UUID) -> Bool {
        guard let notiGroupMO = getNotifGroupMOById(id: id) else {
            return false
        }
        managedObjContext.delete(notiGroupMO)
        coreDataStack.saveContext(managedObjContext)
        return true
    }
    
    // MARK: UPDATE Services
    func updateNotiGroupMO(id: UUID, hour: Int, minute: Int, isOn: Bool, content: String) -> NotiGroupMO? {
        guard let notiGroupMO = getNotifGroupMOById(id: id) else {
            return nil
        }
        notiGroupMO.hour = Int16(hour)
        notiGroupMO.minute = Int16(minute)
        notiGroupMO.isOn = isOn
        notiGroupMO.content = content
        coreDataStack.saveContext(managedObjContext)
        return notiGroupMO
    }
}
