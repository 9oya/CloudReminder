//
//  NotiGroupMO+CoreDataProperties.swift
//  
//
//  Created by 9oya on 2020/08/01.
//
//

import Foundation
import CoreData


extension NotiGroupMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotiGroupMO> {
        return NSFetchRequest<NotiGroupMO>(entityName: "NotiGroupMO")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isOn: Bool
    @NSManaged public var hour: Int16
    @NSManaged public var minute: Int16
    @NSManaged public var content: String?
    @NSManaged public var notiMOs: NotiMO?

}
