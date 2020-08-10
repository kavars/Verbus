//
//  SettingsRouter.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

class SettingsRouter: SettingsRouterProtocol {
    
    weak var tableViewController: SettingsTableViewController!
    
    init(tableViewController: SettingsTableViewController) {
        self.tableViewController = tableViewController
    }
}
