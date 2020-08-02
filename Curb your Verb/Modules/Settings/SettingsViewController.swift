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
        let alert = configureResetAlert(for: "statistic") {
            self.presenter.resetButtonClicked()
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func resetTutorialButtonClicked(_ sender: UIButton) {
        let alert = configureResetAlert(for: "tutorial") {
            self.presenter.resetTutorialButtonClicked()
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - SettingsViewProtocol
    
    func setVibrationSwitchState(with state: Bool) {
        DispatchQueue.main.async {
            self.vibrationSwitch.setOn(state, animated: true)
        }
    }
    
    private func configureResetAlert(for action: String, handler: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: "Reset \(action)", message: "Are you shure?", preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default) { action in
            handler()
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        
        return alert
    }
}
