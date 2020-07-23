//
//  VerbDetailsConfigurator.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

class VerbDetailsConfigurator: VerbDetailsConfiguratorProtocol {
    func configure(with viewController: VerbDetailsViewController, verb: Verb) {
        let presenter = VerbDetailsPresenter(view: viewController)
        let interactor = VerbDetailsInteractor(presenter: presenter, verb: verb)
        let router = VerbDetailsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        
    }
}
