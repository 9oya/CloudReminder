//
//  NotiBodyNotiBodyViewController.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit
import ColorCompatibility
import RxSwift
import RxCocoa

class NotiBodyViewController: UIViewController, NotiBodyViewInput {
    // MARK: Properties
    var subTitleLabel: UILabel!
    var textField: UITextField!
    
    var output: NotiBodyViewOutput!
    var configurator = NotiBodyModuleConfigurator()
    
    let disposeBag = DisposeBag()
    
    var notiDetailViewModel: NotiDetailViewModel!
    
    // MARK: Life cycle
    override func loadView() {
        super.loadView()
        configurator.configureModuleForViewInput(viewInput: self)
        output.viewIsReady()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindInput()
    }
    
    // MARK: Actions
    
    // MARK: NotiBodyViewInput
    func setupInitialState() {
        setupLayout()
    }
}

extension NotiBodyViewController {
    private func bindInput() {
        textField.rx.text.orEmpty
            .bind(to: notiDetailViewModel.contentInputText)
            .disposed(by: disposeBag)
    }
}

extension NotiBodyViewController {
    private func setupLayout() {
        // MARK: Setup super-view
        view.backgroundColor = ColorCompatibility.systemBackground
        navigationItem.title = "Content"
        
        // MARK: Setup sub-view properties
        subTitleLabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14, weight: .bold)
            label.textColor = ColorCompatibility.systemGray2
            label.text = "Type notification content text"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        textField = {
            let textField = UITextField()
            textField.textAlignment = .left
            textField.addLeftPadding()
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = ColorCompatibility.label.cgColor
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
        
        // MARK: Setup UI Hierarchy
        view.addSubview(subTitleLabel)
        view.addSubview(textField)
        
        // MARK: Dependency injection
        
        // MARK: Setup constraints
        subTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        subTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        
        textField.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 10).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
