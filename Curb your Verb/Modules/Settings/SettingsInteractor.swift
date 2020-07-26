//
//  SettingsInteractor.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

class SettingsInteractor: SettingsInteractorProtocol {
    
    weak var presenter: SettingsPresenterProtocol!
    var settingsService: SettingsServiceProtocol = SettingsService()
    
    init(presenter: SettingsPresenterProtocol) {
        self.presenter = presenter
    }
    
    var isVibration: Bool {
        set {
            settingsService.isVibration = newValue
        }
        get {
            return settingsService.isVibration
        }
    }
    
    func resetStatistic() {
        // reset all verbs progress
        settingsService.resetAllStats()
    }
}
