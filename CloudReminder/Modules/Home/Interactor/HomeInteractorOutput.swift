//
//  HomeHomeInteractorOutput.swift
//  CloudReminder
//
//  Created by 9oya on 31/07/2020.
//  Copyright © 2020 dymm. All rights reserved.
//

import Foundation

protocol HomeInteractorOutput: class {
    func insertATableRow(indexPath: IndexPath)
    
    func deleteATableRow(indexPath: IndexPath)
    
    func reloadTableView()
    
    func beginUpdateTalbeView()
    
    func endUpdateTableView()
}
