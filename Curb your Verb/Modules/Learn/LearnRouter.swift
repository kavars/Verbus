//
//  LearnRouter.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

class LearnRouter: LearnRouterProtocol {
    weak var viewController: LearnViewController!
    
    init(viewController: LearnViewController) {
        self.viewController = viewController
    }
}
