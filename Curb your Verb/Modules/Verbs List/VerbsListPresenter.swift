 //
//  VerbsListPresenter.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

 class VerbsListPresenter: VerbsListPresenterProtocol {
    
    weak var tableView: VerbsListTableViewProtocol!
    var interactor: VerbsListInteractorProtocol!
    var router: VerbsListRouterProtocol!
    
    init(tableView: VerbsListTableViewProtocol) {
        self.tableView = tableView
    }
    
    func configureView() {
        tableView.setUpSearchController()
        tableView.setUpTableView()
    }
    
    func getVerbsCount() -> Int {
        return interactor.getVerbsCount()
    }
    
    func getVerb(at index: Int) -> Verb {
        return interactor.getVerb(at: index)
    }
    
    func selectToLearnClicked() {
        if !tableView.isTableEditing {
            tableView.startEditing()
            
            // select all verbs which on learning
            let indexs = interactor.getOnLearningVerbsIndexs()
            for index in indexs {
                tableView.selectVerb(at: index)
            }
        } else {
            if let selectedIndexes = tableView.indexPathsForSelectedRows {
                interactor.applySelectedToLearn(selectedIndexes)
                
                interactor.updateVerbs()
                
                tableView.updateList()
            }
            
            tableView.endEditing()
        }
    }
    
    func viewWillAppear() {
        interactor.updateVerbs()
        
        tableView.updateList()
        tableView.endEditing()
    }
    
    func updateSearchResults() {
        if let searchText = tableView.searchText {
            interactor.searchVerbs(infinitive: searchText)
        }
        
        tableView.updateList()
    }
 }
