//
//  LearnConfigurator.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

class LearnConfigurator: LearnConfiguratorProtocol {
    func configure(with viewController: LearnViewController) {
        let presenter = LearnPresenter(view: viewController)
        let interactor = LearnInteractor(presenter: presenter)
        let router = LearnRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        
        presenter.correctIndicatorView = viewController.correctIndicatorView
    }
}
