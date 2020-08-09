//
//  NotiWeekNotiWeekConfiguratorTests.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

@testable import CloudReminder
import XCTest

class NotiWeekModuleConfiguratorTests: XCTestCase {

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
        let viewController = NotiWeekViewControllerMock()
        let configurator = NotiWeekModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "NotiWeekViewController is nil after configuration")
        XCTAssertTrue(viewController.output is NotiWeekPresenter, "output is not NotiWeekPresenter")

        let presenter: NotiWeekPresenter = viewController.output as! NotiWeekPresenter
        XCTAssertNotNil(presenter.view, "view in NotiWeekPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in NotiWeekPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is NotiWeekRouter, "router is not NotiWeekRouter")

        let interactor: NotiWeekInteractor = presenter.interactor as! NotiWeekInteractor
        XCTAssertNotNil(interactor.output, "output in NotiWeekInteractor is nil after configuration")
    }

    class NotiWeekViewControllerMock: NotiWeekViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
