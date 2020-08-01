//
//  NotiBodyNotiBodyConfigurator.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

class NotiBodyModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? NotiBodyViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: NotiBodyViewController) {

        let router = NotiBodyRouter()

        let presenter = NotiBodyPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = NotiBodyInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
