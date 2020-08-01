//
//  NotiTimeNotiTimeConfigurator.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

class NotiTimeModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? NotiTimeViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: NotiTimeViewController) {

        let router = NotiTimeRouter()

        let presenter = NotiTimePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = NotiTimeInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
