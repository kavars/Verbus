//
//  VerbsListConfigurator.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation
//import UIKit

class VerbsListConfigurator: VerbsListConfiguratorProtocol {
    func configure(with tableViewController: VerbsListTableViewController) {
        let presenter = VerbsListPresenter(tableView: tableViewController)
        let interactor = VerbsListInteractor(presenter: presenter)
        let router = VerbsListRouter(tableViewController: tableViewController)
        
        tableViewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
//        guard let storeService = (UIApplication.shared.delegate as? AppDelegate)?.storeVerbService else {
//            fatalError()
//        }
//        interactor.storeService = storeService
    }
}
