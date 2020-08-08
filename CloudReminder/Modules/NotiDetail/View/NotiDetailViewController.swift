//
//  NotiDetailNotiDetailViewController.swift
//  easy-noti
//
//  Created by 9oya on 01/08/2020.
//  Copyright © 2020 Dymm. All rights reserved.
//

import UIKit
import ColorCompatibility

class NotiDetailViewController: UIViewController, NotiDetailViewInput {
    // MARK: Properties
    // UITableView
    var notiDetailTableView: UITableView!
    
    // UIButton
    var saveButton: UIButton!
    
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
    @objc func saveButtonTapped() {
        let (hour, minute) = DateHelper.shared.convertDateToHourAndMinute(date: customTime)
        output.createNotification(title: customTitle, content: customContent, hour: hour, minute: minute, daysOfWeekDict: daysOfWeekDict, isOn: isOn)
    }

    // MARK: NotiDetailViewInput
    var customTitle = "CloudReminder"
    var customContent = "TestTestTestTestTestTestTestTestTestTestTestTest"
    var customTime: Date = Date()
    var isOn: Bool = true
    var daysOfWeekDict: [Int : Bool] = [1: true, 2: true, 3: true, 4: true, 5: true, 6: true, 7: true]
    
    func setupInitialState() {
        setupLayout()
    }
    
    func setupData(data: NotiGroupMO?) {
        if data != nil {
            output.setupData(notiGroupMO: data!)
        }
    }
}

extension NotiDetailViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return output.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: notiDetailTableFooterId) as! NotiDetailTableFooter
        output.configureNotiDetailTableFooter(view: view)
        view.switchChangedAction = { isOn in
            self.isOn = isOn
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: notiDetailTalbeCellId, for: indexPath) as! NotiDetailTableCell
        output.configureNotiDetailTableCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return view.frame.height / 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 8
    }
}

extension NotiDetailViewController {
    private func setupLayout() {
        // MARK: Setup super-view
        view.backgroundColor = ColorCompatibility.systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Add Notification"
        
        // MARK: Setup sub-view properties
        notiDetailTableView = {
            let tableView = UITableView(frame: .zero, style: .grouped)
            tableView.separatorStyle = .none
            tableView.backgroundColor = ColorCompatibility.systemBackground
            tableView.register(NotiDetailTableFooter.self, forHeaderFooterViewReuseIdentifier: notiDetailTableFooterId)
            tableView.register(NotiDetailTableCell.self, forCellReuseIdentifier: notiDetailTalbeCellId)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }()
        saveButton = {
            let button = UIButton()
            button.setTitle("Save", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
            button.setTitleColor(.systemTeal, for: .normal)
            button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
            return button
        }()
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: saveButton)]
        
        // MARK: Setup UI Hierarchy
        view.addSubview(notiDetailTableView)
        
        // MARK: Dependency injection
        notiDetailTableView.dataSource = self
        notiDetailTableView.delegate = self
        
        // MARK: Setup constraints
        notiDetailTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        notiDetailTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        notiDetailTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        notiDetailTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
}
