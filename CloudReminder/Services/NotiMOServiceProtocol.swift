//
//  NotiMOServiceProtocol.swift
//  CloudReminder
//
//  Created by 9oya on 2020/08/01.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

protocol NotiMOServiceProtocol {
    func createNotiMO(notiGroupMO: NotiGroupMO, id: UUID, weekCode: WeekCode, body: String, isOn: Bool) -> NotiMO
    
    func getNotiMOById(id: UUID) -> NotiMO?
    
    func deleteNotiMOById(id: UUID) -> Bool
    
    func updateNotiMO(id: UUID, isOn: Bool) -> NotiMO?
}
