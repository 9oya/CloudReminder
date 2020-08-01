//
//  NotiDetailNotiDetailPresenterTests.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

@testable import CloudReminder
import XCTest

class NotiDetailPresenterTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    class MockInteractor: NotiDetailInteractorInput {

    }

    class MockRouter: NotiDetailRouterInput {

    }

    class MockViewController: NotiDetailViewInput {

        func setupInitialState() {

        }
    }
}
