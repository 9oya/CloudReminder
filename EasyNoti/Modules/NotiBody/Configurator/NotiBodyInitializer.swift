//
//  NotiBodyNotiBodyInitializer.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

class NotiBodyModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var notibodyViewController: NotiBodyViewController!

    override func awakeFromNib() {

        let configurator = NotiBodyModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: notibodyViewController)
    }

}
