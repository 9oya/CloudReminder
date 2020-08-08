//
//  HomeHomePresenter.swift
//  CloudReminder
//
//  Created by 9oya on 31/07/2020.
//  Copyright © 2020 dymm. All rights reserved.
//

import UIKit

class HomePresenter: HomeModuleInput {
    weak var view: HomeViewInput!
    var interactor: HomeInteractorInput!
    var router: HomeRouterInput!
}

extension HomePresenter: HomeViewOutput {
    // MARK: HomeViewOutput
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func pushToNotiDetailViewController(with data: NotiGroupMO?, from view: UIViewController) {
        router.pushToNotiDetailViewController(with: data, from: view)
    }
}

extension HomePresenter: HomeInteractorOutput {
    // MARK: HomeInteractorOutput
}
