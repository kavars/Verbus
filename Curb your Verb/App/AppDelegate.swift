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
    
    lazy var dailyUpdateService: DailyUpdateServiceProtocol = DailyUpdateService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        dailyUpdateService.dailyUpdater()
        
        activateUIAppearance()
        
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

    private func activateUIAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor(named: "darkSandYellowColor")
        UINavigationBar.appearance().tintColor = UIColor(named: "darkRedColor")
        
        UITabBar.appearance().tintColor = UIColor(named: "darkRedColor")
        UITabBar.appearance().barTintColor = UIColor(named: "darkSandYellowColor")
        
        UITableView.appearance().backgroundColor = UIColor(named: "sandYellowColor")
        UITableViewCell.appearance().backgroundColor = UIColor(named: "sandYellowColor")
    }
}
