//
//  NotiMO+CoreDataProperties.swift
//  
//
//  Created by 9oya on 2020/08/02.
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
    @NSManaged public var notiGroupMO: NotiGroupMO?

}
