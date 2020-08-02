//
//  StrikeService.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 02.08.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

// MARK: - DailyStrikeProtocol

protocol StoreStrikeServiceProtocol: class {
    func savedDailyStrike() -> Int
    func saveDailyStrike(with value: Int)
}

class StoreStrikeService: StoreStrikeServiceProtocol {
    
    private let kSavedDay = "CurbYourVerb.DailyStrike"
    
    func savedDailyStrike() -> Int {
        if UserDefaults.standard.object(forKey: kSavedDay) != nil {
            return UserDefaults.standard.integer(forKey: kSavedDay)
        }
        return 0
    }
    
    func saveDailyStrike(with value: Int) {
        
        if value < 0 {
            UserDefaults.standard.set(0, forKey: kSavedDay)
        } else if value > 6 {
            UserDefaults.standard.set(6, forKey: kSavedDay)
        } else {
            UserDefaults.standard.set(value, forKey: kSavedDay)
        }
        
        UserDefaults.standard.synchronize()
    }
}
