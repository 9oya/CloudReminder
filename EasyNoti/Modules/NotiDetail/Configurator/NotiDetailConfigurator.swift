//
//  NotiDetailNotiDetailConfigurator.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

class NotiDetailModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? NotiDetailViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: NotiDetailViewController) {

        let router = NotiDetailRouter()

        let presenter = NotiDetailPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = NotiDetailInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
