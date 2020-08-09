//
//  NotiGroupViewModel.swift
//  CloudReminder
//
//  Created by 9oya on 2020/08/01.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit
import ColorCompatibility

class NotiGroupViewModel {
    private let notiGroupMO: NotiGroupMO
    
    var title: String {
        return notiGroupMO.title ?? ""
    }
    
    var content: String {
        return notiGroupMO.content ?? ""
    }
    
    var time: String {
        return DateHelper.shared.convertDateToTimeTxt(date: nil, hour: Int(notiGroupMO.hour), minute: Int(notiGroupMO.minute))
    }
    
    var daysOfWeek: String {
        let daysOfWeekDict = NotiMOService.shared.convertNotiMOArrToDaysOfWeekDict(notiMOArr: notiGroupMO.notiMOs?.allObjects as! [NotiMO])
        return DateHelper.shared.convertDaysOfWeekDictToText(daysOfWeekDict: daysOfWeekDict)
    }
    
    init(notiGroupMO: NotiGroupMO) {
        self.notiGroupMO = notiGroupMO
    }
}
