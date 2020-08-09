//
//  NotiDetailNotiDetailRouter.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit
import ColorCompatibility

class NotiDetailRouter: NotiDetailRouterInput {
    func pushToNotiBodyViewController(from view: UIViewController) {
        let vc = NotiBodyViewController()
        vc.notiDetailVC = (view as! NotiDetailViewInput)
        view.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        view.navigationItem.backBarButtonItem?.tintColor = ColorCompatibility.label
        view.navigationController?.pushViewController(vc, animated: true)
    }
}
