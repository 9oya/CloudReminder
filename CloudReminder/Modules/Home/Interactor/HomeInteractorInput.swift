//
//  HomeHomeInteractorInput.swift
//  CloudReminder
//
//  Created by 9oya on 31/07/2020.
//  Copyright © 2020 dymm. All rights reserved.
//

import Foundation

protocol HomeInteractorInput {
    func performFRC()
    
    func numberOfNotiGroups(section: Int) -> Int
    
    func notiGroupAt(indexPath: IndexPath) -> NotiGroupMO?
    
    func configureNotiTableCell(cell: NotiTableCell, indexPath: IndexPath)
}
