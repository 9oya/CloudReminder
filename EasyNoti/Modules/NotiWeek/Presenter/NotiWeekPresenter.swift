//
//  NotiWeekNotiWeekPresenter.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

class NotiWeekPresenter: NotiWeekModuleInput, NotiWeekViewOutput, NotiWeekInteractorOutput {

    weak var view: NotiWeekViewInput!
    var interactor: NotiWeekInteractorInput!
    var router: NotiWeekRouterInput!

    func viewIsReady() {

    }
}
