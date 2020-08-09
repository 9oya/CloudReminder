//
//  NotiDetailNotiDetailRouterInput.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

protocol NotiDetailRouterInput {
    func backToWhereCameFrom(from view: UIViewController)
    
    func pushToNotiBodyViewController(from view: UIViewController)
}
