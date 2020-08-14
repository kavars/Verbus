//
//  VerbDetailsProtocols.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

protocol VerbDetailsViewProtocol: class {
    
    func configure(verb: Verb)
    
    func setCellsView()
        
    func setInfinitiveForm(with string: String)
    func setPastSimpleForm(with string: String)
    func setPastParticipleForm(with string: String)
    
    func setInfinitiveTranscription(with string: String)
    func setPastSimpleTranscription(with string: String)
    func setPastParticipleTranscription(with string: String)
    
    func setTranslation(with string: String)
    
    func setRightAnswersToday(with string: String)
    func setWrongAnswersToday(with string: String)
    func setRightAnswersForAllTime(with string: String)
    func setWrongAnswersForAllTime(with string: String)
}

protocol VerbDetailsInteractorProtocol: class {
    
    var infinitiveForm: String { get }
    var pastSimpleForm: String { get }
    var pastParticipleForm: String { get }
    
    var infinitiveTranscription: String { get }
    var pastSimpleTranscription: String { get }
    var pastParticipleTranscription: String { get }
    
    var translation: String { get }
    
    var rightAnswersToday: Int32 { get }
    var wrongAnswersToday: Int32 { get }
    var rightAnswersForAllTime: Int32 { get }
    var wrongAnswersForAllTime: Int32 { get }
    
    /**
    Activates speech synthesizer for the selected verb form

    - Parameter form: Path to verb form.
    - Parameter IPA: Path to IPA notation of form.

    */
    func activateSpeech(form: KeyPath<Verb, String?>, IPA: KeyPath<Verb, String?>)
}

protocol VerbDetailsPresenterProtocol: class {
    var router: VerbDetailsRouterProtocol! { set get }
    
    func configureView()
    
    func dismissDetailsView()
    
    func infinitiveSpeechButtonClicked()
    func pastSimpleSpeechButtonClicked()
    func pastParticipleSpeechButtonClicked()

}

protocol VerbDetailsConfiguratorProtocol: class {
    func configure(with viewController: VerbDetailsViewController, verb: Verb)
}

protocol VerbDetailsRouterProtocol: class {
    func closeCurrentViewController()
}
