//
//  VerbsListTableViewController.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit

class VerbsListTableViewController: UITableViewController, VerbsListTableViewProtocol {

    var presenter: VerbsListPresenterProtocol!
    let configurator: VerbsListConfiguratorProtocol = VerbsListConfigurator()
    
    var searchController: UISearchController!
    
    let kCellIdentifier = "VerbCell"
    
    // MARK: - View Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewWillAppear()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getVerbsCount(in: section)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.titleForHeader(in: section)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(named: "darkSandYellowColor")
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as? VerbTableViewCell else {
            fatalError()
        }
        
        let verb = presenter.getVerb(at: indexPath)
        cell.configureCellView(infinitive: verb.infinitive, translate: verb.translation)
        
        return cell
    }
    
    // MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !tableView.isEditing {
            tableView.deselectRow(at: indexPath, animated: true)
            self.presenter.router.pushDetailView(at: indexPath)
        }
    }
    
    // MARK: - Actions
    @objc func selectToLearn() {
        presenter.selectToLearnClicked()
    }
    
    // MARK: - VerbsListTableViewProtocol
    var isTableEditing: Bool {
        get {
            return tableView.isEditing
        }
    }
    
    var indexPathsForSelectedRows: [IndexPath]? {
        get {
            return tableView.indexPathsForSelectedRows
        }
    }
    
    func toggleSearchController() {
        DispatchQueue.main.async {
            if self.tableView.tableHeaderView == nil {
                self.tableView.tableHeaderView = self.searchController.searchBar
            } else {
                self.tableView.tableHeaderView = nil
            }
        }
    }
    
    func setUpSearchController() {
        DispatchQueue.main.async {
            self.searchController = UISearchController(searchResultsController: nil)
            self.searchController.searchResultsUpdater = self
            
            self.searchController.obscuresBackgroundDuringPresentation = false
            self.searchController.searchBar.sizeToFit()
            
            self.searchController.searchBar.searchBarStyle = .minimal
            self.searchController.searchBar.tintColor = UIColor(named: "darkRedColor")
            self.searchController.searchBar.placeholder = "Поиск"
            
            self.searchController.searchBar.keyboardAppearance = .dark
        }
    }
    
    func setUpTableView() {
        // register cell
        self.tableView.register(VerbTableViewCell.self, forCellReuseIdentifier: kCellIdentifier)

        DispatchQueue.main.async {
            // search part
            self.tableView.tableHeaderView = self.searchController.searchBar
            self.definesPresentationContext = true
            
            // allow check verbs to learning list
            self.tableView.allowsMultipleSelectionDuringEditing = true
            
            let editButton = UIBarButtonItem(image: UIImage(systemName: "book"), style: .plain, target: self, action: #selector(self.selectToLearn))
            
            self.navigationItem.leftBarButtonItem = editButton
            self.title = "Таблица глаголов"
            self.tableView.rowHeight = 44
        }
    }
    
    func startEditing() {
        DispatchQueue.main.async {
            self.tableView.setEditing(true, animated: true)
            self.navigationItem.leftBarButtonItem?.title = "Готово"
            self.navigationItem.leftBarButtonItem?.image = nil
        }
    }
    
    func selectVerb(at index: IndexPath) {
        DispatchQueue.main.async {
            self.tableView.selectRow(at: index, animated: true, scrollPosition: .none)
        }
    }
    
    func endEditing() {
        DispatchQueue.main.async {
            self.tableView.setEditing(false, animated: true)
            self.navigationItem.leftBarButtonItem?.title = nil
            self.navigationItem.leftBarButtonItem?.image = UIImage(systemName: "book")
        }
    }
    
    func updateList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

// MARK: - UISearchResultsUpdating

extension VerbsListTableViewController: UISearchResultsUpdating {
    
    // add fetch predicate by search text
    func updateSearchResults(for searchController: UISearchController) {
        presenter.updateSearchResults()
    }
    
    var searchText: String? {
        get {
            return searchController.searchBar.text
        }
    }
}
