//
//  NotiDetailNotiDetailInteractorInput.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import Foundation

protocol NotiDetailInteractorInput {
    func setupData(notiGroupMO: NotiGroupMO)
    
    func configureNotiDetailTableFooter(view: NotiDetailTableFooter)
    
    func configureNotiDetailTableCell(cell: NotiDetailTableCell, indexPath: IndexPath)
    
    func configureEmptyNotiDetail() -> [[String: String]]
    
    func configureSelectedNotiDetail(notiGroupMO: NotiGroupMO) -> [[String: String]]
    
    func numberOfSections() -> Int
    
    func numberOfRows() -> Int
    
    func detailDictArrAt(notiGroupMO: NotiGroupMO?, indexPath: IndexPath) -> [String: String]
    
    func createNotification(title: String, content: String, hour: Int, minute: Int, daysOfWeekDict: [Int: Bool], isOn: Bool) -> NotiGroupMO
}
