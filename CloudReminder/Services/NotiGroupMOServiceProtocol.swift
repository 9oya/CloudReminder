//
//  NotiGroupMOServiceProtocol.swift
//  CloudReminder
//
//  Created by 9oya on 2020/08/01.
//  Copyright © 2020 Dymm. All rights reserved.
//

import CoreData

protocol NotiGroupMOServiceProtocol {
    func createNotiGroupMO(id: UUID, hour: Int, minute: Int, isOn: Bool, title: String, content: String) -> NotiGroupMO
    
    func getNotifGroupMOById(id: UUID) -> NotiGroupMO?
    
    func getNotiGroupMOFRC() -> NSFetchedResultsController<NotiGroupMO>
    
    func deleteNotifGroupMOById(id: UUID) -> Bool
    
    func updateNotiGroupMO(id: UUID, hour: Int, minute: Int, isOn: Bool, content: String) -> NotiGroupMO?
}
