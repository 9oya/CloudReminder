//
//  HomeHomeInitializer.swift
//  EasyNoti
//
//  Created by 9oya on 31/07/2020.
//  Copyright © 2020 dymm. All rights reserved.
//

import UIKit

class HomeModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var homeViewController: HomeViewController!

    override func awakeFromNib() {

        let configurator = HomeModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: homeViewController)
    }

}
