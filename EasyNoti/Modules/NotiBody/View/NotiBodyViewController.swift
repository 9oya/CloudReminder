//
//  NotiBodyNotiBodyViewController.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

class NotiBodyViewController: UIViewController, NotiBodyViewInput {

    var output: NotiBodyViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: NotiBodyViewInput
    func setupInitialState() {
    }
}
