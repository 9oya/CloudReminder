//
//  NotiDetailNotiDetailPresenter.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

class NotiDetailPresenter: NotiDetailModuleInput {
    weak var view: NotiDetailViewInput!
    var interactor: NotiDetailInteractorInput!
    var router: NotiDetailRouterInput!
}

extension NotiDetailPresenter: NotiDetailViewOutput {
    // MARK: NotiDetailViewOutput
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func setupData(getData: (() -> NotiGroupMO?)?) {
        interactor.getData = getData
    }
    
    func configureNotiDetailTableFooter(view: NotiDetailTableFooter) {
        interactor.configureNotiDetailTableFooter(view: view)
    }
    
    func configureNotiDetailTableCell(cell: NotiDetailTableCell, indexPath: IndexPath) {
        interactor.configureNotiDetailTableCell(cell: cell, indexPath: indexPath)
    }
    
    func numberOfSections() -> Int {
        return interactor.numberOfSections()
    }
    
    func numberOfRows() -> Int {
        return interactor.numberOfRows()
    }
    
    func createNotification(title: String, content: String, hour: Int, minute: Int, daysOfWeekDict: [Int : Bool], isOn: Bool) {
        _ = interactor.createNotification(title: title, content: content, hour: hour, minute: minute, daysOfWeekDict: daysOfWeekDict, isOn: isOn)
    }
}

extension NotiDetailPresenter: NotiDetailInteractorOutput {
    // MARK: NotiDetailInteractorOutput
}
