//
//  HomeHomeRouter.swift
//  CloudReminder
//
//  Created by 9oya on 31/07/2020.
//  Copyright © 2020 dymm. All rights reserved.
//

import UIKit

class HomeRouter: HomeRouterInput {
    func pushToNotiDetailViewController(with data: NotiGroupMO? = nil, from view: UIViewController) {
        let vc = NotiDetailViewController()
        vc.setupData(data: data)
        view.navigationController?.pushViewController(vc, animated: true)
    }
}
