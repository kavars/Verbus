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
    func openSystemSettings()
}

protocol SettingsInteractorProtocol: class {
    var isVibration: Bool { set get }

    func resetStatistic()
    func resetTutorial()
}

protocol SettingsPresenterProtocol: class {
    var router: SettingsRouterProtocol! { set get }
    
    func configureView()
    
    // Action methods
    
    func vibrationSwitchToggled(to state: Bool)
    func resetButtonClicked()
    func resetTutorialButtonClicked()
    func systemSettingsButtonClicked()
}

protocol SettingsConfiguratorProtocol: class {
    func configure(with viewController: SettingsViewController)
}

protocol SettingsRouterProtocol: class {
    func openSystemSettings()
}
