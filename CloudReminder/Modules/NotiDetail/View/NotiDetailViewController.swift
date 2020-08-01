//
//  NotiDetailNotiDetailViewController.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

class NotiDetailViewController: UIViewController, NotiDetailViewInput {
    // MARK: Properties
    // Delegates
    var output: NotiDetailViewOutput!
    
    // Dependency injection
    var configurator = NotiDetailModuleConfigurator()

    // MARK: Life cycle
    override func loadView() {
        super.loadView()
        configurator.configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Actions

    // MARK: NotiDetailViewInput
    func setupInitialState() {
        setupLayout()
    }
}

extension NotiDetailViewController {
    private func setupLayout() {
        // MARK: Setup super-view
        
        // MARK: Setup sub-view properties
        
        // MARK: Setup UI Hierarchy
        
        // MARK: Dependency injection
        
        // MARK: Setup constraints
    }
}
