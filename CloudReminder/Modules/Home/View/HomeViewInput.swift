//
//  HomeHomeViewInput.swift
//  CloudReminder
//
//  Created by 9oya on 31/07/2020.
//  Copyright © 2020 dymm. All rights reserved.
//

import Foundation

protocol HomeViewInput: class {

    /**
        @author 9oya
        Setup initial state of the view
    */

    func setupInitialState()
    
    func insertATableRow(indexPath: IndexPath)
    
    func deleteATableRow(indexPath: IndexPath)
    
    func reloadTableView()
    
    func beginUpdateTalbeView()
    
    func endUpdateTableView()
}
