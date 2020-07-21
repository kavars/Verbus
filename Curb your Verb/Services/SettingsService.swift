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
}

class SettingsService: SettingsServiceProtocol {
    
    var storeService: StoreServiceSettingsProtocol = StoreService()
    
    var isVibration: Bool {
        set {
            storeService.saveVibration(with: newValue)
        }
        get {
            return storeService.savedVibration()
        }
    }
    
}
