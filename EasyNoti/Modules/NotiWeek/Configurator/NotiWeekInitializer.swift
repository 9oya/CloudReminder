//
//  NotiWeekNotiWeekInitializer.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

class NotiWeekModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var notiweekViewController: NotiWeekViewController!

    override func awakeFromNib() {

        let configurator = NotiWeekModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: notiweekViewController)
    }

}
