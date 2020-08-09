//
//  NotiMOServiceProtocol.swift
//  CloudReminder
//
//  Created by 9oya on 2020/08/01.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

protocol NotiMOServiceProtocol {
    func convertNotiMOArrToDaysOfWeekDict(notiMOArr: [NotiMO]) -> [Int: Bool]
    
    func createNotiMO(notiGroupMO: NotiGroupMO, id: UUID, weekCode: WeekCode, isOn: Bool) -> NotiMO
    
    func getNotiMOById(id: UUID) -> NotiMO?
    
    func getAllNotiMOs() -> [NotiMO]?
    
    func deleteNotiMOById(id: UUID) -> Bool
    
    func updateNotiMO(id: UUID, isOn: Bool) -> NotiMO?
}
