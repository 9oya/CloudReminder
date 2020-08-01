//
//  NotiTimeNotiTimePresenter.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

class NotiTimePresenter: NotiTimeModuleInput {
    weak var view: NotiTimeViewInput!
    var interactor: NotiTimeInteractorInput!
    var router: NotiTimeRouterInput!
}

extension NotiTimePresenter: NotiTimeViewOutput {
    // MARK: NotiTimeViewOutput
    func viewIsReady() {
        view.setupInitialState()
    }
}

extension NotiTimePresenter: NotiTimeInteractorOutput {
    // MARK: NotiTimeInteractorOutput
}
