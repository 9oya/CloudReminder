//
//  HomeHomeViewController.swift
//  EasyNoti
//
//  Created by 9oya on 31/07/2020.
//  Copyright © 2020 dymm. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeViewInput {

    let configurator = HomeModuleConfigurator()
    var output: HomeViewOutput!

    // MARK: Life cycle
    override func loadView() {
        super.loadView()
        configurator.configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: HomeViewInput
    func setupInitialState() {
        setupLayout()
    }
}

extension HomeViewController {
    private func setupLayout() {
        // MARK: Setup super-view
        
        // MARK: Setup sub-view properties
        
        // MARK: Setup UI Hierarchy
    }
}
