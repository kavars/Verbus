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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getVerbsCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VerbCell", for: indexPath) as? VerbTableViewCell else {
            fatalError()
        }
        
        let verb = presenter.getVerb(at: indexPath.item)
        cell.configureCellView(infinitive: verb.infinitive, translate: verb.translation)
        
        return cell
    }
    
    // MARK: - Actions
    
    @IBAction func selectToLearn(_ sender: UIBarButtonItem) {
        presenter.selectToLearnClicked()
    }
    
    // MARK: - VerbsListTableViewProtocol
    func setUpSearchController() {
        DispatchQueue.main.async {
            self.searchController = UISearchController(searchResultsController: nil)
            self.searchController.searchResultsUpdater = self
            
            self.searchController.obscuresBackgroundDuringPresentation = false
            self.searchController.searchBar.sizeToFit()
        }
    }
    
    func setUpTableView() {
        DispatchQueue.main.async {
            // search part
            self.tableView.tableHeaderView = self.searchController.searchBar
            self.definesPresentationContext = true
            
            // allow check verbs to learning list
            self.tableView.allowsMultipleSelectionDuringEditing = true
        }
    }
    
    func startEditing() {
        DispatchQueue.main.async {
            self.tableView.setEditing(true, animated: true)
            self.navigationItem.leftBarButtonItem?.title = "Done"
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
            self.navigationItem.leftBarButtonItem?.title = "Select To Learn"
        }
    }
    
    func updateList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }



    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            super.prepare(for: segue, sender: sender)
            presenter.router.prepare(for: segue, sender: sender)
    }
    
    // restrict segue when editing
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return !tableView.isEditing
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
