//
//  VerbDetailsViewController.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit
import AVFoundation

class VerbDetailsViewController: UIViewController, VerbDetailsViewProtocol {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var infinitive: UILabel!
    @IBOutlet weak var pastSimple: UILabel!
    @IBOutlet weak var pastParticiple: UILabel!
    
    @IBOutlet weak var infinitiveTranscription: UILabel!
    @IBOutlet weak var pastSimpleTranscription: UILabel!
    @IBOutlet weak var pastParticipleTranscription: UILabel!
    
    @IBOutlet weak var translation: UILabel!
    
    @IBOutlet weak var rightAnswersToday: UILabel!
    @IBOutlet weak var wrongAnswersToday: UILabel!
    @IBOutlet weak var rightAnswersForAllTime: UILabel!
    @IBOutlet weak var wrongAnswersForAllTime: UILabel!
    
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var wrongView: UIView!
    
    
    // MARK: - IBActions
    
    @IBAction func speechInfinitiveClicked(_ sender: UIButton) {
        presenter.infinitiveSpeechButtonClicked()
    }
    
    @IBAction func speechPastSimpleClicked(_ sender: UIButton) {
        presenter.pastSimpleSpeechButtonClicked()
    }
    
    @IBAction func speechPastParticipleClicked(_ sender: UIButton) {
        presenter.pastParticipleSpeechButtonClicked()
    }
    
    
    var presenter: VerbDetailsPresenterProtocol!
    let configurator: VerbDetailsConfiguratorProtocol = VerbDetailsConfigurator()
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.configureView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter.dismissDetailsView()
    }
    
    func configure(verb: Verb) {
        configurator.configure(with: self, verb: verb)
    }
    
    // MARK: - VerbDetailsViewProtocol
    
    private func setUpCornerRadius(in view: UIView, with radius: CGFloat) {
        view.layer.masksToBounds = true
        view.layer.cornerRadius = radius
    }
    
    func setCellsView() {
        let cornerR: CGFloat = 10
        
        setUpCornerRadius(in: infinitive, with: cornerR)
        setUpCornerRadius(in: pastSimple, with: cornerR)
        setUpCornerRadius(in: pastParticiple, with: cornerR)

        setUpCornerRadius(in: infinitiveTranscription, with: cornerR)
        setUpCornerRadius(in: pastSimpleTranscription, with: cornerR)
        setUpCornerRadius(in: pastParticipleTranscription, with: cornerR)
        
        setUpCornerRadius(in: translation, with: cornerR)
        
        setUpCornerRadius(in: rightLabel, with: cornerR)
        setUpCornerRadius(in: wrongLabel, with: cornerR)
        setUpCornerRadius(in: rightView, with: cornerR)
        setUpCornerRadius(in: wrongView, with: cornerR)
    }
    
    func setInfinitiveForm(with string: String) {
        DispatchQueue.main.async {
            self.infinitive.text = string
        }
    }
    
    func setPastSimpleForm(with string: String) {
        DispatchQueue.main.async {
            self.pastSimple.text = string
        }
    }
    
    func setPastParticipleForm(with string: String) {
        DispatchQueue.main.async {
            self.pastParticiple.text = string
        }
    }
    
    func setInfinitiveTranscription(with string: String) {
        DispatchQueue.main.async {
            self.infinitiveTranscription.text = string
        }
    }
    
    func setPastSimpleTranscription(with string: String) {
        DispatchQueue.main.async {
            self.pastSimpleTranscription.text = string
        }
    }
    
    func setPastParticipleTranscription(with string: String) {
        DispatchQueue.main.async {
            self.pastParticipleTranscription.text = string
        }
    }
    
    func setTranslation(with string: String) {
        DispatchQueue.main.async {
            self.translation.text = string
        }
    }
    
    func setRightAnswersToday(with string: String) {
        DispatchQueue.main.async {
            self.rightAnswersToday.text = string
        }
    }
    
    func setWrongAnswersToday(with string: String) {
        DispatchQueue.main.async {
            self.wrongAnswersToday.text = string
        }
        
    }
    
    func setRightAnswersForAllTime(with string: String) {
        DispatchQueue.main.async {
            self.rightAnswersForAllTime.text = string
        }
    }
    
    func setWrongAnswersForAllTime(with string: String) {
        DispatchQueue.main.async {
            self.wrongAnswersForAllTime.text = string
        }
    }
}
