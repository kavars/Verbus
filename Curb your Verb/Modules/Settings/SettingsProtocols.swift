//
//  SettingsProtocols.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

protocol SettingsViewProtocol: class {
    func setVibrationSwitchState(with state: Bool)
}

protocol SettingsInteractorProtocol: class {
    var isVibration: Bool { set get }

    func resetStatistic()
}

protocol SettingsPresenterProtocol: class {
    var router: SettingsRouterProtocol! { set get }
    
    func configureView()
    
    // Action methods
    
    func vibrationSwitchToggled(to state: Bool)
    func resetButtonClicked()
}

protocol SettingsConfiguratorProtocol: class {
    func configure(with viewController: SettingsViewController)
}

protocol SettingsRouterProtocol: class {
    
}
