//
//  NotiDetailNotiDetailPresenter.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

class NotiDetailPresenter: NotiDetailModuleInput, NotiDetailViewOutput, NotiDetailInteractorOutput {

    weak var view: NotiDetailViewInput!
    var interactor: NotiDetailInteractorInput!
    var router: NotiDetailRouterInput!

    func viewIsReady() {

    }
}
