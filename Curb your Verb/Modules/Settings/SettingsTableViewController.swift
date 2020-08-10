//
//  SettingsTableViewController.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 10.08.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, SettingsViewProtocol {
    
    var presenter: SettingsPresenterProtocol!
    let configurator: SettingsConfiguratorProtocol = SettingsConfigurator()
    
    // MARK: - Vibrate section
    @IBOutlet weak var vibrationOnMistakesCell: UITableViewCell!
    
    @IBOutlet weak var vibrateOnMistakesSwitch: UISwitch!
    
    @IBAction func vibrateOnMistakesSwitched(_ sender: UISwitch) {
        presenter.vibrationSwitchToggled(to: sender.isOn)
    }
    
    // MARK: - Reset section
    @IBOutlet weak var resetTutorialCell: UITableViewCell!
    @IBOutlet weak var resetProgressCell: UITableViewCell!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        switch cell {
        case resetTutorialCell:
            let alert = configureAlert(for: "Сброс обучения", with: "Вы уверены?", okStyle: .default) {
                self.presenter.resetTutorialButtonClicked()
            }
            
            present(alert, animated: true, completion: nil)
            resetTutorialCell.isSelected = false
        case resetProgressCell:
            let alert = configureAlert(for: "Сброс прогресса", with: "Вы уверены?", okStyle: .destructive) {
                self.presenter.resetProgressButtonClicked()
            }
            
            present(alert, animated: true, completion: nil)
            resetProgressCell.isSelected = false
        default:
            break
        }
    }

    // MARK: - SettingsViewProtocol
    
    func setVibrationSwitchState(with state: Bool) {
        DispatchQueue.main.async {
            self.vibrateOnMistakesSwitch.setOn(state, animated: false)
        }
    }
    
    private func configureAlert(for action: String, with message: String, okStyle: UIAlertAction.Style, handler: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: action, message: message, preferredStyle: .alert)
        
        alert.view.layer.backgroundColor = Colors.sandYellowColor.cgColor
        alert.view.layer.cornerRadius = 10
        alert.view.layer.masksToBounds = true
        alert.view.tintColor = Colors.darkRedColor
        
        let actionOK = UIAlertAction(title: "ОК", style: okStyle) { action in
            handler()
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)

        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        
        return alert
    }
    
    func setCellsSettings() {
        vibrationOnMistakesCell.selectionStyle = .none
    }
}
