//
//  NotiMOService.swift
//  CloudReminder
//
//  Created by 9oya on 2020/08/01.
//  Copyright © 2020 Dymm. All rights reserved.
//

import CoreData

class NotiMOService: NotiMOServiceProtocol {
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
