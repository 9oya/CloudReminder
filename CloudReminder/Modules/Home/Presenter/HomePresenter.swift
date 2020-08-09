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
    
    func performFRC() {
        interactor.performFRC()
    }
    
    func numberOfNotiGroups(section: Int) -> Int {
        interactor.numberOfNotiGroups(section: section)
    }
    
    func notiGroupAt(indexPath: IndexPath) -> NotiGroupMO? {
        return interactor.notiGroupAt(indexPath: indexPath)
    }
    
    func configureNotiTableCell(cell: NotiTableCell, indexPath: IndexPath) {
        interactor.configureNotiTableCell(cell: cell, indexPath: indexPath)
    }
    
    func pushToNotiDetailViewController(with data: NotiGroupMO?, from view: UIViewController) {
        router.pushToNotiDetailViewController(with: data, from: view)
    }
}

extension HomePresenter: HomeInteractorOutput {
    // MARK: HomeInteractorOutput
    func insertATableRow(indexPath: IndexPath) {
        view.insertATableRow(indexPath: indexPath)
    }
    
    func deleteATableRow(indexPath: IndexPath) {
        view.deleteATableRow(indexPath: indexPath)
    }
    
    func reloadTableView() {
        view.reloadTableView()
    }
    
    func beginUpdateTalbeView() {
        view.beginUpdateTalbeView()
    }
    
    func endUpdateTableView() {
        view.endUpdateTableView()
    }
}
