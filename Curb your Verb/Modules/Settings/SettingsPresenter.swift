//
//  SettingsPresenter.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

class SettingsPresenter: SettingsPresenterProtocol {
    
    weak var view: SettingsViewProtocol!
    var interactor: SettingsInteractorProtocol!
    
    var router: SettingsRouterProtocol!
    
    init(view: SettingsViewProtocol) {
        self.view = view
    }
    
    var isVibration: Bool {
        set {
            interactor.isVibration = newValue
        }
        get {
            return interactor.isVibration
        }
    }
    
    // MARK: - SettingsPresenterProtocol methods
    
    func configureView() {
        view.setVibrationSwitchState(with: isVibration)
    }
    
    func vibrationSwitchToggled(to state: Bool) {
        isVibration = state
    }
    
    func resetButtonClicked() {
        interactor.resetStatistic()
    }
    
    func resetTutorialButtonClicked() {
        interactor.resetTutorial()
    }
    
    func systemSettingsButtonClicked() {
        router.openSystemSettings()
    }
}
