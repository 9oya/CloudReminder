//
//  HomeHomePresenterTests.swift
//  CloudReminder
//
//  Created by 9oya on 31/07/2020.
//  Copyright © 2020 dymm. All rights reserved.
//

@testable import CloudReminder
import XCTest

class HomePresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: HomeInteractorInput {
        func performFRC() {
            
        }
        
        func numberOfNotiGroups(section: Int) -> Int {
            return 0
        }
        
        func notiGroupAt(indexPath: IndexPath) -> NotiGroupMO? {
            return NotiGroupMO()
        }
        
        func configureNotiTableCell(cell: NotiTableCell, indexPath: IndexPath) {
            
        }
    }

    class MockRouter: HomeRouterInput {
        func pushToNotiDetailViewController(with data: NotiGroupMO?, from view: UIViewController) {
            
        }
    }

    class MockViewController: HomeViewInput {
        func setupInitialState() {

        }
        
        func insertATableRow(indexPath: IndexPath) {
            
        }
        
        func deleteATableRow(indexPath: IndexPath) {
            
        }
        
        func reloadTableView() {
            
        }
        
        func beginUpdateTalbeView() {
            
        }
        
        func endUpdateTableView() {
            
        }
    }
}
