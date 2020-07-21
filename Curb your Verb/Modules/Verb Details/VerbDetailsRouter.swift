//
//  VerbDetailsRouter.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

class VerbDetailsRouter: VerbDetailsRouterProtocol {
    weak var viewController: VerbDetailsViewController!
    
    init(viewController: VerbDetailsViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        if let owningNavigationController = viewController.navigationController {
            owningNavigationController.popViewController(animated: true)
        }
    }
}
