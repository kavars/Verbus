//
//  TabBarViewController.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 06.08.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    lazy var settingsService: SettingsServiceProtocol = SettingsService()

    override func viewDidLoad() {
        super.viewDidLoad()

        launchTutorialView()

    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if tabBar.items?.first == item {
            launchTutorialView()
        } else if tabBar.items?[1] == item {
            launchTutorialViewTable()
        }
    }
    
    private func launchTutorialView() {
        if settingsService.isTutorial {
            view.addSubview(TutorialView(frame: view.frame))
        }
    }
    
    private func launchTutorialViewTable() {
        if settingsService.isTutorialTable {
            view.addSubview(TutorialViewTable(frame: view.frame))
        }
    }

}
