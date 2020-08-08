//
//  NotiDetailNotiDetailInteractor.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import Foundation
import UIKit

class NotiDetailInteractor: NotiDetailInteractorInput {
    
    var notiGroupMO: NotiGroupMO?

    weak var output: NotiDetailInteractorOutput!
    
    func setupData(notiGroupMO: NotiGroupMO) {
        self.notiGroupMO = notiGroupMO
    }
    
    func configureNotiDetailTableFooter(view: NotiDetailTableFooter) {
        view.guideLabel.text = "On/Off"
        if notiGroupMO != nil {
            view.notiSwitch.setOn(notiGroupMO!.isOn, animated: false)
            view.deleteButton.isHidden = false
        } else {
            view.notiSwitch.setOn(true, animated: false)
            view.deleteButton.isHidden = true
        }
    }
    
    func configureNotiDetailTableCell(cell: NotiDetailTableCell, indexPath: IndexPath) {
        var detailDict: [String: String]!
        if let notiGroupMO = notiGroupMO {
            detailDict = detailDictArrAt(notiGroupMO: notiGroupMO, indexPath: indexPath)
        } else {
            detailDict = detailDictArrAt(notiGroupMO: nil, indexPath: indexPath)
        }
        cell.guideLabel.text = detailDict["guide"]
        cell.contentLabel.text = detailDict["content"]
    }

    func configureEmptyNotiDetail() -> [[String: String]] {
        var detailDictArr = [[String: String]]()
        let daysOfWeekDict = [1: true, 2: true, 3: true, 4: true, 5: true, 6: true, 7: true]
        detailDictArr.append([
            "guide": "Title",
            "content": "CloudReminder"
        ])
        detailDictArr.append([
            "guide": "Content",
            "content": ""
        ])
        detailDictArr.append([
            "guide": "Time",
            "content": DateHelper.shared.convertDateToTimeTxt(date: Date())
        ])
        detailDictArr.append([
            "guide": "Repeat",
            "content": convertDaysOfWeekDictToText(daysOfWeekDict: daysOfWeekDict)
        ])
        return detailDictArr
    }
    
    func configureSelectedNotiDetail(notiGroupMO: NotiGroupMO) -> [[String: String]] {
        var detailDictArr = [[String: String]]()
        let notiGroupViewModel = NotiGroupViewModel(notiGroupMO: notiGroupMO)
        let notiMOArr = notiGroupMO.notiMOs!.allObjects as! [NotiMO]
        detailDictArr.append([
            "guide": "Title",
            "content": notiGroupViewModel.title
        ])
        detailDictArr.append([
            "guide": "Content",
            "content": notiGroupViewModel.content
        ])
        detailDictArr.append([
            "guide": "Time",
            "content": notiGroupViewModel.time
        ])
        detailDictArr.append([
            "guide": "Repeat",
            "content": convertDaysOfWeekDictToText(daysOfWeekDict: convertNotiMOArrToDaysOfWeekDict(notiMOArr: notiMOArr))
        ])
        return detailDictArr
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return configureEmptyNotiDetail().count
    }
    
    func detailDictArrAt(notiGroupMO: NotiGroupMO? = nil, indexPath: IndexPath) -> [String: String] {
        if notiGroupMO != nil {
            return configureSelectedNotiDetail(notiGroupMO: notiGroupMO!)[indexPath.row]
        } else {
            return configureEmptyNotiDetail()[indexPath.row]
        }
    }
    
    func createNotification(title: String, content: String, hour: Int, minute: Int, daysOfWeekDict: [Int: Bool], isOn: Bool) -> NotiGroupMO {
        // Create a CoreData NotiGroupMO
        let notiGroupMO = NotiGroupMOService.shared.createNotiGroupMO(id: UUID(), hour: hour, minute: minute, isOn: isOn, title: title, content: content)
        
        if !isOn {
            return notiGroupMO
        }
        
        // Create CoreData NotiMOs
        let notiMOService = NotiMOService(coreDataStack: NotiGroupMOService.shared.coreDataStack)
        var notiMOArr = [NotiMO]()
        for (weekCode, isSelected) in daysOfWeekDict {
            if isSelected {
                let notiMO = notiMOService.createNotiMO(notiGroupMO: notiGroupMO, id: UUID(), weekCode: WeekCode(rawValue: weekCode)!, isOn: isSelected)
                notiMOArr.append(notiMO)
            } else {
                // do nothing...
            }
        }
        
        // Schedule local notifications
        let localNotiScheduler = LocalNotiScheduler()
        if var _notiMOArr = notiMOService.getAllNotiMOs() {
            _notiMOArr += notiMOArr
            localNotiScheduler.notiMOArr = _notiMOArr
        } else {
            localNotiScheduler.notiMOArr = notiMOArr
        }
        localNotiScheduler.schedule()
        return notiGroupMO
    }
}

extension NotiDetailInteractor {
    private func convertNotiMOArrToDaysOfWeekDict(notiMOArr: [NotiMO]) -> [Int: Bool] {
        var daysOfWeekDict = [1: false, 2: false, 3: false, 4: false, 5: false, 6: false, 7: false]
        for notiMO in notiMOArr {
            daysOfWeekDict[Int(notiMO.weekCode)]?.toggle()
        }
        return daysOfWeekDict
    }
    
    private func convertDaysOfWeekDictToText(daysOfWeekDict: [Int: Bool]) -> String {
        var daysOfWeekTxt = ""
        if daysOfWeekDict[1]! {
            daysOfWeekTxt += "Sun/"
        }
        if daysOfWeekDict[2]! {
            daysOfWeekTxt += "Mon/"
        }
        if daysOfWeekDict[3]! {
            daysOfWeekTxt += "Tue/"
        }
        if daysOfWeekDict[4]! {
            daysOfWeekTxt += "Wed/"
        }
        if daysOfWeekDict[5]! {
            daysOfWeekTxt += "Thu/"
        }
        if daysOfWeekDict[6]! {
            daysOfWeekTxt += "Fri/"
        }
        if daysOfWeekDict[7]! {
            daysOfWeekTxt += "Sat"
        }
        
        var result = ""
        let daysOfWeekTxtArr = daysOfWeekTxt.split(separator: "/")
        for (idx, dayOfWeek) in daysOfWeekTxtArr.enumerated() {
            if idx + 1 >= daysOfWeekTxtArr.count {
                result += "\(dayOfWeek)"
            } else {
                result += "\(dayOfWeek)·"
            }
        }
        
        if result == "Sun·Mon·Tue·Wed·Thu·Fri·Sat" {
            result = "Everyday"
        } else if result == "Mon·Tue·Wed·Thu·Fri" {
            result = "Weekdays"
        } else if result == "Sun·Sat" {
            result = "Weekend"
        } else {
            return result
        }
        return result
    }
}
