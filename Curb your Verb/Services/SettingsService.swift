//
//  SettingsService.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

protocol SettingsServiceProtocol: class {
    var isVibration: Bool { set get }
    
    func resetAllStats()
}

class SettingsService: SettingsServiceProtocol {
    
    lazy var storeSettingsService: StoreServiceSettingsProtocol = StoreSettingsService()
    lazy var storeServiceVerbs: StoreServiceVerbsProtocol = StoreServiceCoreData(modelName: "Curb_your_Verb")
    
    var isVibration: Bool {
        set {
            storeSettingsService.saveVibration(with: newValue)
        }
        get {
            return storeSettingsService.savedVibration()
        }
    }
    
    func resetAllStats() {
        storeServiceVerbs = StoreServiceCoreData(modelName: "Curb_your_Verb")
        
        guard let verbs = storeServiceVerbs.verbsFetchAll() else {
            return
        }
        
        for verb in verbs {
            verb.isLearn = true
            verb.progress?.rightAnswersToday = 0
            verb.progress?.rightAnswersForAllTime = 0
            verb.progress?.wrongAnswersToday = 0
            verb.progress?.wrongAnswersForAllTime = 0
        }
        
        storeServiceVerbs.saveContext()
    }
}
