//
//  NotiTimeNotiTimeInitializer.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

class NotiTimeModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var notitimeViewController: NotiTimeViewController!

    override func awakeFromNib() {

        let configurator = NotiTimeModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: notitimeViewController)
    }

}
