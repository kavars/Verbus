//
//  AppDelegate.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        dailyUpdater()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

extension AppDelegate {
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
