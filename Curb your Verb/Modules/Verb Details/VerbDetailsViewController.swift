//
//  VerbDetailsViewController.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit

class VerbDetailsViewController: UIViewController, VerbDetailsViewProtocol {
    
    weak var tmpVerb: Verb?
    
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
    

    var presenter: VerbDetailsPresenterProtocol!
    let configurator: VerbDetailsConfiguratorProtocol = VerbDetailsConfigurator()

    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurator.configure(with: self)
        // tmp
        presenter.setVerb(verb: tmpVerb!)
        presenter.configureView()
    }
    
//    deinit {
//        print("deinit details")
//    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // back to the Verbs Table
        // if let owningNavigationController = navigationController {
        //     owningNavigationController.popViewController(animated: true)
        // }
        presenter.dismissDetailsView()
        
    }

    // MARK: - VerbDetailsViewProtocol
    
    func setVerb(verb: Verb) {
        // tmp
        tmpVerb = verb
//        presenter.setVerb(verb: verb)
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