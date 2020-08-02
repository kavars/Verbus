//
//  SettingsService.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation
import CoreData


//import UIKit // ?

protocol SettingsServiceProtocol: class {
    var isVibration: Bool { set get }
    
    func resetAllStats()
}

class SettingsService: SettingsServiceProtocol {
    
    lazy var storeSettingsService: StoreServiceSettingsProtocol = StoreSettingsService()
//    lazy var storeServiceVerbs: StoreServiceVerbsProtocol = {
//        guard let storeService = (UIApplication.shared.delegate as? AppDelegate)?.storeVerbService else {
//            fatalError()
//        }
//
//        return storeService
//    }() //StoreServiceCoreData(modelName: "Curb_your_Verb")
    
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
        storeServiceVerbs.updateContext()
//        storeServiceVerbs = StoreServiceCoreData(modelName: "Curb_your_Verb")
        storeServiceVerbs.resetStats()
    }
}
