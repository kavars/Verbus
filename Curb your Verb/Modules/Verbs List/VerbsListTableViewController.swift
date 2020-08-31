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
    
    let searchController: UISearchController = UISearchController(searchResultsController: nil)
    
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
            if self.navigationItem.searchController == nil {
                self.navigationItem.searchController = self.searchController
                self.navigationController?.view.setNeedsLayout()
                self.navigationController?.view.layoutIfNeeded()
            } else {
                self.navigationItem.searchController = nil
                self.navigationController?.view.setNeedsLayout()
                self.navigationController?.view.layoutIfNeeded()
            }
        }
    }
    
    func setUpSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Поиск"
        
        self.navigationItem.searchController?.isEditing = true
        self.searchController.searchBar.keyboardAppearance = .dark

    }
    
    // TODO: Add icons
    func setUpToolBar() {
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let addAllVerbsButton = UIBarButtonItem(title: "50", style: .plain, target: self, action: #selector(selectAll50))
        let removeAllVerbsButton = UIBarButtonItem(title: "0", style: .plain, target: self, action: #selector(deselectAll))
        
        let addAllVerbsButton200 = UIBarButtonItem(title: "200", style: .plain, target: self, action: #selector(selectAll200))
        
        setToolbarItems([removeAllVerbsButton, spacer, addAllVerbsButton, addAllVerbsButton200], animated: false)
    }
    
    @objc func selectAll50() {
        let rowsCount50 = tableView.numberOfRows(inSection: 0)
        for i in 0..<rowsCount50 {
            self.tableView.selectRow(at: IndexPath(row: i, section: 0), animated: true, scrollPosition: .none)
        }
    }
    
    @objc func selectAll200() {
        let rowsCount200 = tableView.numberOfRows(inSection: 1)
        for i in 0..<rowsCount200 {
            self.tableView.selectRow(at: IndexPath(row: i, section: 1), animated: true, scrollPosition: .none)
        }
    }
    
    @objc func deselectAll() {
        let rowsCount50 = tableView.numberOfRows(inSection: 0)
        for i in 0..<rowsCount50 {
            self.tableView.deselectRow(at: IndexPath(row: i, section: 0), animated: true)
        }
        
        let rowsCount200 = tableView.numberOfRows(inSection: 1)
        for i in 0..<rowsCount200 {
            self.tableView.deselectRow(at: IndexPath(row: i, section: 1), animated: true)
        }
    }
    
    func setUpTableView() {
        // register cell
        self.tableView.register(VerbTableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
        
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        self.definesPresentationContext = true
        
        // allow check verbs to learning list
        self.tableView.allowsMultipleSelectionDuringEditing = true
        
        let editButton = UIBarButtonItem(image: UIImage(systemName: "book"), style: .plain, target: self, action: #selector(self.selectToLearn))
        
        self.navigationItem.leftBarButtonItem = editButton
        self.title = "Таблица глаголов"
        self.tableView.rowHeight = 44
    }
    
    func startEditing() {
        DispatchQueue.main.async {
            self.tableView.setEditing(true, animated: true)
            self.navigationItem.leftBarButtonItem?.title = "Готово"
            self.navigationItem.leftBarButtonItem?.image = nil
            
            self.navigationController?.setToolbarHidden(false, animated: true)
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
            
            self.navigationController?.setToolbarHidden(true, animated: true)
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
