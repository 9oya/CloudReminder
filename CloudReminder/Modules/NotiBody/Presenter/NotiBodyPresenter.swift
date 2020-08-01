//
//  NotiBodyNotiBodyPresenter.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

class NotiBodyPresenter: NotiBodyModuleInput {
    weak var view: NotiBodyViewInput!
    var interactor: NotiBodyInteractorInput!
    var router: NotiBodyRouterInput!
}

extension NotiBodyPresenter: NotiBodyViewOutput {
    // MARK: NotiBodyViewOutput
    func viewIsReady() {
        view.setupInitialState()
    }
}

extension NotiBodyPresenter: NotiBodyInteractorOutput {
    // MARK: NotiBodyInteractorOutput
}
