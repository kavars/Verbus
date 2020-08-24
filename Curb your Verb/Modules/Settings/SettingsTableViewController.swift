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
    var vibrationOnMistakesCell: UITableViewCell = UITableViewCell()
    
    var vibrateOnMistakesSwitch: UISwitch = {
        let vibrationSwitch = UISwitch()
        vibrationSwitch.onTintColor = UIColor(named: "darkRedColor")
        
        vibrationSwitch.addTarget(self, action: #selector(vibrateOnMistakesSwitched), for: .valueChanged)
        
        return vibrationSwitch
    }()
    
    @objc func vibrateOnMistakesSwitched() {
        presenter.vibrationSwitchToggled(to: vibrateOnMistakesSwitch.isOn)
    }
    
    // MARK: - Reset section
    var resetTutorialCell: UITableViewCell = UITableViewCell()
    var resetProgressCell: UITableViewCell = UITableViewCell()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return vibrationOnMistakesCell
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return resetTutorialCell
            case 1:
                return resetProgressCell
            default:
                fatalError()
            }
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Вибрация"
        case 1:
            return "Сброс"
        default:
            return nil
        }
    }
    
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
        
        alert.view.layer.backgroundColor = UIColor(named: "sandYellowColor")?.cgColor // Colors.sandYellowColor.cgColor
        alert.view.layer.cornerRadius = 10
        alert.view.layer.masksToBounds = true
        alert.view.tintColor = UIColor(named: "darkRedColor") // Colors.darkRedColor
        
        let actionOK = UIAlertAction(title: "ОК", style: okStyle) { action in
            handler()
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)

        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        
        return alert
    }
    
    func setCellsSettings() {
        DispatchQueue.main.async {
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor(named: "cellSelectedColor")
            
            
            self.vibrationOnMistakesCell.textLabel?.text = "Вибрация при ошибке"
            self.vibrationOnMistakesCell.textLabel?.textColor = UIColor(named: "darkGreyColor")
            self.vibrationOnMistakesCell.selectionStyle = .none
            
            self.vibrationOnMistakesCell.addSubview(self.vibrateOnMistakesSwitch)
            
            self.vibrateOnMistakesSwitch.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                self.vibrateOnMistakesSwitch.centerYAnchor.constraint(equalTo: self.vibrationOnMistakesCell.centerYAnchor),
                self.vibrateOnMistakesSwitch.trailingAnchor.constraint(equalTo:
                    self.vibrationOnMistakesCell.trailingAnchor, constant: -16)
            ])

            self.resetTutorialCell.textLabel?.text = "Сброс обучения"
            self.resetTutorialCell.textLabel?.textColor = UIColor(named: "darkRedColor")
            self.resetTutorialCell.selectedBackgroundView = bgColorView
            
            self.resetProgressCell.textLabel?.text = "Сброс прогресса"
            self.resetProgressCell.textLabel?.textColor = .red
            self.resetProgressCell.selectedBackgroundView = bgColorView
        }

    }
    
    func setTableViewSettings() {
        DispatchQueue.main.async {
            self.navigationItem.title = "Настройки"
            
            self.tableView.separatorColor = UIColor(named: "darkRedColor")
            self.tableView.rowHeight = 44
        }
    }
}
