//
//  NotiDetailNotiDetailInitializer.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

class NotiDetailModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var notidetailViewController: NotiDetailViewController!

    override func awakeFromNib() {

        let configurator = NotiDetailModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: notidetailViewController)
    }

}
