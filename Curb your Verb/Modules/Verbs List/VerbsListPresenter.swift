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
        
    }
    
    func getVerbsCount() -> Int {
        return interactor.getVerbsCount()
    }
    
    func getVerb(at index: Int) -> Verb {
        return interactor.getVerb(at: index)
    }
    
    func updateVerbs() {
        interactor.updateVerbs()
    }
    
    func searchVerbs(infinitive: String) {
        interactor.searchVerbs(infinitive: infinitive)
    }
    
    func getOnLearningVerbsIndexs() -> [IndexPath] {
        return interactor.getOnLearningVerbsIndexs()
    }
    
    func applySelectedToLearn(_ indexes: [IndexPath]) {
        interactor.applySelectedToLearn(indexes)
    }
 }
