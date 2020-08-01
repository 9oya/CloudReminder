//
//  NotiMO+CoreDataProperties.swift
//  
//
//  Created by 9oya on 2020/08/01.
//
//

import Foundation
import CoreData


extension NotiMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotiMO> {
        return NSFetchRequest<NotiMO>(entityName: "NotiMO")
    }

    @NSManaged public var body: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isOn: Bool
    @NSManaged public var weekCode: Int16
    @NSManaged public var notiGroupMO: NSSet?

}

// MARK: Generated accessors for notiGroupMO
extension NotiMO {

    @objc(addNotiGroupMOObject:)
    @NSManaged public func addToNotiGroupMO(_ value: NotiGroupMO)

    @objc(removeNotiGroupMOObject:)
    @NSManaged public func removeFromNotiGroupMO(_ value: NotiGroupMO)

    @objc(addNotiGroupMO:)
    @NSManaged public func addToNotiGroupMO(_ values: NSSet)

    @objc(removeNotiGroupMO:)
    @NSManaged public func removeFromNotiGroupMO(_ values: NSSet)

}
