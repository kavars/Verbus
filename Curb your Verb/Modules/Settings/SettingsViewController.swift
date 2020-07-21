//
//  SettingsViewController.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewProtocol {

    var presenter: SettingsPresenterProtocol!
    let configurator: SettingsConfiguratorProtocol = SettingsConfigurator()
    
    @IBOutlet weak var vibrationSwitch: UISwitch!
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurator.configure(with: self)
        presenter.configureView()
    }
    
    // MARK: - Action methods

    @IBAction func vibrationSwitchToggled(_ sender: UISwitch) {
        presenter.vibrationSwitchToggled(to: sender.isOn)
    }
    
    @IBAction func resetButtonClicked(_ sender: UIButton) {
        presenter.resetButtonClicked()
    }
    
    // MARK: - SettingsViewProtocol
    
    func setVibrationSwitchState(with state: Bool) {
        DispatchQueue.main.async {
            self.vibrationSwitch.setOn(state, animated: true)
        }
    }
}
