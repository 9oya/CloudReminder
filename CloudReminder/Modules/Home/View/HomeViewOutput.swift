//
//  HomeHomeViewOutput.swift
//  CloudReminder
//
//  Created by 9oya on 31/07/2020.
//  Copyright © 2020 dymm. All rights reserved.
//

import UIKit

protocol HomeViewOutput {

    /**
        @author 9oya
        Notify presenter that view is ready
    */

    func viewIsReady()
    
    func pushToNotiDetailViewController(with data: NotiGroupMO?, from view: UIViewController)
}
