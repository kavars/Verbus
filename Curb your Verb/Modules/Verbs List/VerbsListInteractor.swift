//
//  VerbsListInteractor.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

class VerbsListInteractor: VerbsListInteractorProtocol {
    
    weak var presenter: VerbsListPresenterProtocol!
    
    var storeService: StoreServiceVerbsFetchedResultsControllerProtocol = StoreServiceCoreData(modelName: "Curb_your_Verb")
    
//    var verbs: [Verb] = []
    
    var search: String = ""
    
    init(presenter: VerbsListPresenterProtocol) {
        self.presenter = presenter
        
        storeService.fetchResultsController()
//        if let verbs = storeService.verbsFetch(of: .search(infinitive: self.search)){
//            self.verbs = verbs
//        }
    }
    
    func updateVerbs() {
        // update store?
//        storeService.updateContext()
        storeService = StoreServiceCoreData(modelName: "Curb_your_Verb")
        
        storeService.fetchResultsController()
        
//        if let verbs = storeService.verbsFetch(of: .search(infinitive: self.search)){
//            self.verbs = verbs
//        }
    }
    
    func numberOfSections() -> Int {
        return storeService.fetchedResultsController.sections?.count ?? 0
    }
    
    func titleForHeader(in section: Int) -> String? {
        let selectionInfo = storeService.fetchedResultsController.sections?[section]
        return selectionInfo?.name
    }
    
    func getVerbsCount(in section: Int) -> Int {
        guard let sectionInfo = storeService.fetchedResultsController.sections?[section] else {
          return 0
        }
        
        return sectionInfo.numberOfObjects
    }
    
    func getVerb(at indexPath: IndexPath) -> Verb {
        return storeService.fetchedResultsController.object(at: indexPath)
    }
    
    func searchVerbs(infinitive: String) {
        storeService = StoreServiceCoreData(modelName: "Curb_your_Verb")
        
        self.search = infinitive
        
        storeService.fetchResultsController()
//        if let verbs = storeService.verbsFetch(of: .search(infinitive: self.search)){
//            self.verbs = verbs
//        }
    }
    
    func getOnLearningVerbsIndexs() -> [IndexPath] {
        var indexs: [IndexPath] = []
        
        guard let sectionsCount = storeService.fetchedResultsController.sections?.count else {
            fatalError()
        }
        
        for section in 0..<sectionsCount {
            let sectionInfo = storeService.fetchedResultsController.sections?[section]
            
            guard let verbs = sectionInfo?.objects as? [Verb] else {
                fatalError()
            }
            
            for (i, verb) in verbs.enumerated() {
                if verb.isLearn {
                    let index = IndexPath(row: i, section: section)
                    indexs.append(index)
                }
            }
            
        }
        
        return indexs
    }
    
    func applySelectedToLearn(_ indexes: [IndexPath]) {
        guard let verbs = storeService.fetchedResultsController.fetchedObjects else {
            return
        }
        
        verbs.forEach {
            $0.isLearn = false
        }
        
        for index in indexes {
            let verb = storeService.fetchedResultsController.object(at: index)
            verb.isLearn = true
        }
        storeService.saveContext()
    }
}
