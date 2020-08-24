//
//  TabBarViewController.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 06.08.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let storyboardName = "Main"
    
    lazy var settingsService: SettingsServiceProtocol = SettingsService()

    override func viewDidLoad() {
        super.viewDidLoad()

        launchTutorialView()
                
        addLearnView()
        addVerbsListView()
        addSettingsView()
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
    
    private func addLearnView() {
        let viewControllerStoryboardId = "learnVC"
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        let learnVC = storyboard.instantiateViewController(withIdentifier: viewControllerStoryboardId) as! LearnViewController
        
        learnVC.tabBarItem = UITabBarItem(title: "Изучение", image: UIImage(systemName: "book"), tag: 0)
                
        viewControllers = [learnVC]
    }
    
    private func addVerbsListView() {
        let viewControllerStoryboardId = "verbsListVC"
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        let verbsListVC = storyboard.instantiateViewController(withIdentifier: viewControllerStoryboardId) as! VerbsListTableViewController
        
        verbsListVC.tabBarItem = UITabBarItem(title: "Таблица глаголов", image: UIImage(systemName: "table"), tag: 1)
        
        let nav = UINavigationController(rootViewController: verbsListVC)
        
        viewControllers?.append(nav)
    }
    
    private func addSettingsView() {        
        let settingsVC = SettingsTableViewController(style: .grouped)
        
        settingsVC.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(systemName: "gear"), tag: 2)
        
        let nav = UINavigationController(rootViewController: settingsVC)
        
        viewControllers?.append(nav)
    }

}
