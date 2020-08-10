//
//  NotiDetailNotiDetailViewOutput.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

protocol NotiDetailViewOutput {

    /**
        @author 9oya
        Notify presenter that view is ready
    */
    
    func viewIsReady()
    
    func setupData(getData: (() -> NotiGroupMO?)?)
    
    func setupContent(getContent: (() -> String?)?)
    
    func configureNotiDetailTableFooter(view: NotiDetailTableFooter)
    
    func configureNotiDetailTableCell(cell: NotiDetailTableCell, indexPath: IndexPath)
    
    func numberOfSections() -> Int
    
    func numberOfRows() -> Int
    
    func createNotification(title: String, content: String, hour: Int, minute: Int, daysOfWeekDict: [Int: Bool], isOn: Bool)
    
    func backToWhereCameFrom(from view: UIViewController)
    
    func pushToNotiBodyViewController(from view: UIViewController, notiDetailViewModel: NotiDetailViewModel)
}
