//
//  NotiDetailNotiDetailViewInput.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import Foundation

protocol NotiDetailViewInput: class {

    /**
        @author 9oya
        Setup initial state of the view
    */
    
    var customTitle: String { get set }
    
    var customContent: String { get set }
    
    var customTime: Date { get set }
    
    var isOn: Bool { get set }
    
    var daysOfWeekDict: [Int: Bool] { get set }
    
    func setupInitialState()
    
    func setupData(data: NotiGroupMO?)
}
