//
//  NotiDetailNotiDetailInteractorInput.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import Foundation

protocol NotiDetailInteractorInput {
    var getData: (() -> NotiGroupMO?)! { get set }
    
    var getContent: (() -> String?)! { get set }
    
    func configureNotiDetailTableFooter(view: NotiDetailTableFooter)
    
    func configureNotiDetailTableCell(cell: NotiDetailTableCell, indexPath: IndexPath)
    
    func numberOfSections() -> Int
    
    func numberOfRows() -> Int
    
    func createNotification(title: String, content: String, hour: Int, minute: Int, daysOfWeekDict: [Int: Bool], isOn: Bool) -> NotiGroupMO
}
