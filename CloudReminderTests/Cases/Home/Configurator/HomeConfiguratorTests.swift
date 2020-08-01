//
//  HomeHomeConfiguratorTests.swift
//  EasyNoti
//
//  Created by 9oya on 31/07/2020.
//  Copyright © 2020 dymm. All rights reserved.
//

@testable import EasyNoti
import XCTest

class HomeModuleConfiguratorTests: XCTestCase {

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
        let viewController = HomeViewControllerMock()
        let configurator = HomeModuleConfigurator()

        //when
        configurator.configureModuleForViewInput(viewInput: viewController)

        //then
        XCTAssertNotNil(viewController.output, "HomeViewController is nil after configuration")
        XCTAssertTrue(viewController.output is HomePresenter, "output is not HomePresenter")

        let presenter: HomePresenter = viewController.output as! HomePresenter
        XCTAssertNotNil(presenter.view, "view in HomePresenter is nil after configuration")
        XCTAssertNotNil(presenter.router, "router in HomePresenter is nil after configuration")
        XCTAssertTrue(presenter.router is HomeRouter, "router is not HomeRouter")

        let interactor: HomeInteractor = presenter.interactor as! HomeInteractor
        XCTAssertNotNil(interactor.output, "output in HomeInteractor is nil after configuration")
    }

    class HomeViewControllerMock: HomeViewController {

        var setupInitialStateDidCall = false

        override func setupInitialState() {
            setupInitialStateDidCall = true
        }
    }
}
