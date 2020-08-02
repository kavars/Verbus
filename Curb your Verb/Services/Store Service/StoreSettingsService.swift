//
//  StoreSettingsService.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 02.08.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

// MARK: - StoreServiceSettings
protocol StoreServiceSettingsProtocol {
    func savedVibration() -> Bool
    func saveVibration(with value: Bool)
    
    func savedDay() -> Date
    func saveDay(with value: Date)
    
    func savedTutorial() -> Bool
    func saveTutorial(with value: Bool)
    
    func savedNotifications() -> Bool
    func saveNotifications(with value: Bool)
}

class StoreSettingsService: StoreServiceSettingsProtocol {
    
    private let kSavedVibrationState = "CurbYourVerb.savedVibrationState"
    private let kSavedDay = "CurbYourVerb.savedDay"
    private let kSavedTutorial = "CurbYourVerb.savedTutorial"
    private let kSavedNotifications = "CurbYourVerb.savedNotifications"
    
    func savedVibration() -> Bool {
        if UserDefaults.standard.object(forKey: kSavedVibrationState) != nil {
            return UserDefaults.standard.bool(forKey: kSavedVibrationState)
        }
        return true
    }
    
    func saveVibration(with value: Bool) {
        UserDefaults.standard.set(value, forKey: kSavedVibrationState)
        UserDefaults.standard.synchronize()
    }
    
    func savedDay() -> Date {
        if UserDefaults.standard.object(forKey: kSavedDay) != nil {
            return UserDefaults.standard.object(forKey: kSavedDay) as! Date
        }
        return Date()
    }
    
    func saveDay(with value: Date) {
        UserDefaults.standard.set(value, forKey: kSavedDay)
        UserDefaults.standard.synchronize()
    }
    
    func savedTutorial() -> Bool {
        if UserDefaults.standard.object(forKey: kSavedTutorial) != nil {
            return UserDefaults.standard.bool(forKey: kSavedTutorial)
        }
        return true
    }
    
    func saveTutorial(with value: Bool) {
        UserDefaults.standard.set(value, forKey: kSavedTutorial)
        UserDefaults.standard.synchronize()
    }
    
    func savedNotifications() -> Bool {
        if UserDefaults.standard.object(forKey: kSavedNotifications) != nil {
            return UserDefaults.standard.bool(forKey: kSavedNotifications)
        }
        return false
    }
    
    func saveNotifications(with value: Bool) {
        UserDefaults.standard.set(value, forKey: kSavedNotifications)
        UserDefaults.standard.synchronize()
    }
}
