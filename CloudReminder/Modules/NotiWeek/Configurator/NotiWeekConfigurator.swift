//
//  NotiWeekNotiWeekConfigurator.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

class NotiWeekModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? NotiWeekViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: NotiWeekViewController) {

        let router = NotiWeekRouter()

        let presenter = NotiWeekPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = NotiWeekInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
