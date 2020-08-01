//
//  HomeHomeViewController.swift
//  EasyNoti
//
//  Created by 9oya on 31/07/2020.
//  Copyright © 2020 dymm. All rights reserved.
//

import UIKit
import ColorCompatibility

class HomeViewController: UIViewController, HomeViewInput {
    // MARK: Properties
    // UISearchController
    var searchController: UISearchController!
    
    // UITableView
    var notiTableView: UITableView!
    
    // Delegates
    var output: HomeViewOutput!
    
    // Dependency injection
    let configurator = HomeModuleConfigurator()

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

extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate {
    // MARK: UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
    }
    
    // MARK: UISearchBarDelegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchText = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchText = searchBar.text
//        if searchBar.text?.isEmpty ?? true {
//            return
//        }
//        output.searchProducts(text: searchBar.text!)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: notiTalbeCellId, for: indexPath) as? NotiTableCell else {
            fatalError()
        }
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension HomeViewController {
    private func setupLayout() {
        // MARK: Setup super-view
        view.backgroundColor = ColorCompatibility.systemBackground
        navigationItem.title = ""
        
        // MARK: Setup sub-view properties
        // UISearchController
        searchController = {
            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            return searchController
        }()
        navigationItem.searchController = searchController
        
        // UITableView
        notiTableView = {
            let tableView = UITableView()
            tableView.backgroundColor = .clear
            tableView.separatorStyle = .none
            tableView.register(NotiTableCell.self, forCellReuseIdentifier: notiTalbeCellId)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }()
        
        // MARK: Setup UI Hierarchy
        view.addSubview(notiTableView)
        
        // MARK: Dependency injection
        searchController.searchBar.delegate = self
        notiTableView.dataSource = self
        notiTableView.delegate = self
        
        // MARK: Setup constraints
        notiTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        notiTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        notiTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        notiTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
}
