//
//  SettingsService.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation
import CoreData

protocol SettingsServiceProtocol: class {
    var isVibration: Bool { set get }
    var isTutorial: Bool { set get }
    var isTutorialTable: Bool { set get }
    
    func resetAllStats()
}

class SettingsService: SettingsServiceProtocol {
    
    lazy var storeSettingsService: StoreServiceSettingsProtocol = StoreSettingsService()
    lazy var storeServiceVerbs: StoreVerbsServiceProtocol = StoreVerbsService(modelName: "Curb_your_Verb")
    lazy var storeStrikeService: StoreStrikeServiceProtocol = StoreStrikeService()
    
    var isVibration: Bool {
        set {
            storeSettingsService.saveVibration(with: newValue)
        }
        get {
            return storeSettingsService.savedVibration()
        }
    }
    
    var isTutorial: Bool {
        set {
            storeSettingsService.saveTutorial(with: newValue)
        }
        get {
            return storeSettingsService.savedTutorial()
        }
    }
    
    var isTutorialTable: Bool {
        set {
            storeSettingsService.saveTutorialTable(with: newValue)
        }
        get {
            return storeSettingsService.savedTutorialTable()
        }
    }
    
    func resetAllStats() {
        storeServiceVerbs.refreshContext()
        storeServiceVerbs.resetStats()
        
        storeStrikeService.saveDailyStrike(with: 0)
    }
    

}
