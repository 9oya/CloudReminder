//
//  NotiTimeNotiTimeConfiguratorTests.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

@testable import CloudReminder
import XCTest

class NotiTimeModuleConfiguratorTests: XCTestCase {

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
        let viewController = NotiTimeViewControllerMock()
        let configurator = NotiTimeModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "NotiTimeViewController is nil after configuration")
        XCTAssertTrue(viewController.output is NotiTimePresenter, "output is not NotiTimePresenter")

        let presenter: NotiTimePresenter = viewController.output as! NotiTimePresenter
        XCTAssertNotNil(presenter.view, "view in NotiTimePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in NotiTimePresenter is nil after configuration")
        XCTAssertTrue(presenter.router is NotiTimeRouter, "router is not NotiTimeRouter")

        let interactor: NotiTimeInteractor = presenter.interactor as! NotiTimeInteractor
        XCTAssertNotNil(interactor.output, "output in NotiTimeInteractor is nil after configuration")
    }

    class NotiTimeViewControllerMock: NotiTimeViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
