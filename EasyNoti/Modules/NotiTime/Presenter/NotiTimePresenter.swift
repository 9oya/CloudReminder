//
//  NotiTimeNotiTimePresenter.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

class NotiTimePresenter: NotiTimeModuleInput, NotiTimeViewOutput, NotiTimeInteractorOutput {

    weak var view: NotiTimeViewInput!
    var interactor: NotiTimeInteractorInput!
    var router: NotiTimeRouterInput!

    func viewIsReady() {

    }
}
