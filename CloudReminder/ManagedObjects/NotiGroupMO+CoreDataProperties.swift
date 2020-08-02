//
//  NotiGroupMO+CoreDataProperties.swift
//  
//
//  Created by 9oya on 2020/08/02.
//
//

import Foundation
import CoreData


extension NotiGroupMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotiGroupMO> {
        return NSFetchRequest<NotiGroupMO>(entityName: "NotiGroupMO")
    }

    @NSManaged public var content: String?
    @NSManaged public var hour: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var isOn: Bool
    @NSManaged public var minute: Int16
    @NSManaged public var notiMOs: NSSet?

}

// MARK: Generated accessors for notiMOs
extension NotiGroupMO {

    @objc(addNotiMOsObject:)
    @NSManaged public func addToNotiMOs(_ value: NotiMO)

    @objc(removeNotiMOsObject:)
    @NSManaged public func removeFromNotiMOs(_ value: NotiMO)

    @objc(addNotiMOs:)
    @NSManaged public func addToNotiMOs(_ values: NSSet)

    @objc(removeNotiMOs:)
    @NSManaged public func removeFromNotiMOs(_ values: NSSet)

}
