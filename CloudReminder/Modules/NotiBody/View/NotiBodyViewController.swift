//
//  NotiBodyNotiBodyViewController.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit

class NotiBodyViewController: UIViewController, NotiBodyViewInput {
    // MARK: Properties
    // Delegates
    var output: NotiBodyViewOutput!
    
    // Dependency injection
    var configurator = NotiBodyModuleConfigurator()

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
    
    // MARK: NotiBodyViewInput
    func setupInitialState() {
        setupLayout()
    }
}

extension NotiBodyViewController {
    private func setupLayout() {
        // MARK: Setup super-view
        
        // MARK: Setup sub-view properties
        
        // MARK: Setup UI Hierarchy
        
        // MARK: Dependency injection
        
        // MARK: Setup constraints
    }
}
