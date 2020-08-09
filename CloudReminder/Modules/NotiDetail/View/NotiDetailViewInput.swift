//
//  NotiDetailNotiDetailViewInput.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import Foundation
import RxSwift

protocol NotiDetailViewInput: class {

    /**
        @author 9oya
        Setup initial state of the view
    */
    
    var notiDetailViewModel: NotiDetailViewModel { get set }
    
    func setupInitialState()
    
    func setupData(data: NotiGroupMO?)
    
    func reloadTableView()
}
