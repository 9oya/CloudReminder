//
//  NotiDetailNotiDetailConfiguratorTests.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

@testable import CloudReminder
import XCTest

class NotiDetailModuleConfiguratorTests: XCTestCase {

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
        let viewController = NotiDetailViewControllerMock()
        let configurator = NotiDetailModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "NotiDetailViewController is nil after configuration")
        XCTAssertTrue(viewController.output is NotiDetailPresenter, "output is not NotiDetailPresenter")

        let presenter: NotiDetailPresenter = viewController.output as! NotiDetailPresenter
        XCTAssertNotNil(presenter.view, "view in NotiDetailPresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in NotiDetailPresenter is nil after configuration")
        XCTAssertTrue(presenter.router is NotiDetailRouter, "router is not NotiDetailRouter")

        let interactor: NotiDetailInteractor = presenter.interactor as! NotiDetailInteractor
        XCTAssertNotNil(interactor.output, "output in NotiDetailInteractor is nil after configuration")
    }

    class NotiDetailViewControllerMock: NotiDetailViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
