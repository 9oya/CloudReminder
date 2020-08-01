//
//  NotiDetailNotiDetailViewController.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

class NotiDetailViewController: UIViewController, NotiDetailViewInput {

    var output: NotiDetailViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: NotiDetailViewInput
    func setupInitialState() {
    }
}
