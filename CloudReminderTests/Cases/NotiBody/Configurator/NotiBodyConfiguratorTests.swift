//
//  NotiBodyNotiBodyConfiguratorTests.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

@testable import EasyNoti
import XCTest

class NotiBodyModuleConfiguratorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureModuleForViewController() {

        //given
        let viewController = NotiBodyViewControllerMock()
        let configurator = NotiBodyModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "NotiBodyViewController is nil after configuration")
        XCTAssertTrue(viewController.output is NotiBodyPresenter, "output is not NotiBodyPresenter")

        let presenter: NotiBodyPresenter = viewController.output as! NotiBodyPresenter
        XCTAssertNotNil(presenter.view, "view in NotiBodyPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in NotiBodyPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is NotiBodyRouter, "router is not NotiBodyRouter")

        let interactor: NotiBodyInteractor = presenter.interactor as! NotiBodyInteractor
        XCTAssertNotNil(interactor.output, "output in NotiBodyInteractor is nil after configuration")
    }

    class NotiBodyViewControllerMock: NotiBodyViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
