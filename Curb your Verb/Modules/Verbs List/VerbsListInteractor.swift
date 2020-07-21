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
    
    var storeService: StoreServiceVerbsProtocol = StoreServiceCoreData(modelName: "Curb_your_Verb")
    
    var verbs: [Verb] = []
    
    var search: String = ""
    
    init(presenter: VerbsListPresenterProtocol) {
        self.presenter = presenter
        
        if let verbs = storeService.verbsSearchInfinitiveFetch(infinitive: self.search) {
            self.verbs = verbs
        }
    }
    
    func updateVerbs() {
        // update store?
        storeService = StoreServiceCoreData(modelName: "Curb_your_Verb")
        if let verbs = storeService.verbsSearchInfinitiveFetch(infinitive: self.search) {
            self.verbs = verbs
        }
    }
    
    func getVerbsCount() -> Int {
        return verbs.count
    }
    
    func getVerb(at index: Int) -> Verb {
        return verbs[index]
    }
    
    func searchVerbs(infinitive: String) {
        storeService = StoreServiceCoreData(modelName: "Curb_your_Verb")
        
        self.search = infinitive
        
        if let verbs = storeService.verbsSearchInfinitiveFetch(infinitive: self.search) {
            self.verbs = verbs
        }
    }
    
    func getOnLearningVerbsIndexs() -> [IndexPath] {
        var indexs: [IndexPath] = []
        
        for (i, verb) in verbs.enumerated() {
            if verb.isLearn {
                let index = IndexPath(row: i, section: 0)
                indexs.append(index)
            }
        }
        
        return indexs
    }
    
    func applySelectedToLearn(_ indexes: [IndexPath]) {
        verbs.forEach {
            $0.isLearn = false
        }
        
        for index in indexes {
            let verb = verbs[index.row]
            
            verb.isLearn = true
        }
        storeService.saveContext()
    }
}
