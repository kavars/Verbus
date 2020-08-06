//
//  DailyUpdateService.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 06.08.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

protocol DailyUpdateServiceProtocol: class {
    func dailyUpdater()
}

class DailyUpdateService: DailyUpdateServiceProtocol {
    func dailyUpdater() {
        let storeDayService: StoreServiceSettingsProtocol = StoreSettingsService()
        let storeStrikeService: StoreStrikeServiceProtocol = StoreStrikeService()
        
        let now = Date()
        let previousDate = storeDayService.savedDay()
        
        if Calendar.current.isDate(now, inSameDayAs: previousDate) {
            storeDayService.saveDay(with: now)
            return
        }
        
        if storeDayService.savedNotifications() {
            _ = UserNotificationsService()
        }
        
        storeDayService.saveDay(with: now)
        
        let storeVerbsService = StoreVerbsService(modelName: "Curb_your_Verb")

        storeVerbsService.newDayUpdate()
        
        storeStrikeService.saveDailyStrike(with: 0)
    }
}
