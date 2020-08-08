//
//  NotiGroupMOService.swift
//  CloudReminder
//
//  Created by 9oya on 2020/08/01.
//  Copyright © 2020 Dymm. All rights reserved.
//

import CoreData

class NotiGroupMOService: NotiGroupMOServiceProtocol {
    // MARK: Properties
    static let shared = NotiGroupMOService(coreDataStack: CoreDataStack())
    var managedObjContext: NSManagedObjectContext
    var coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.managedObjContext = coreDataStack.mainContext
        self.coreDataStack = coreDataStack
    }
    
    // MARK: CREATE Services
    func createNotiGroupMO(id: UUID, hour: Int, minute: Int, isOn: Bool, title: String, content: String) -> NotiGroupMO {
        let newNotiGroupMO = NotiGroupMO(context: managedObjContext)
        newNotiGroupMO.id = id
        newNotiGroupMO.hour = Int16(hour)
        newNotiGroupMO.minute = Int16(minute)
        newNotiGroupMO.isOn = isOn
        newNotiGroupMO.title = title
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
