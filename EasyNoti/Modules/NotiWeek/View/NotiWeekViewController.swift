//
//  NotiWeekNotiWeekViewController.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

class NotiWeekViewController: UIViewController, NotiWeekViewInput {

    var output: NotiWeekViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: NotiWeekViewInput
    func setupInitialState() {
    }
}
