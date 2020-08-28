//
//  SettingsConfigurator.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

class SettingsConfigurator: SettingsConfiguratorProtocol {
    func configure(with tableViewController: SettingsTableViewController) {
        let presenter = SettingsPresenter(view: tableViewController)
        let interactor = SettingsInteractor(presenter: presenter)
        let router = SettingsRouter(tableViewController: tableViewController)
        
        tableViewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
