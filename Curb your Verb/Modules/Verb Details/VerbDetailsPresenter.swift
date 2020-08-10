//
//  VerbDetailsPresenter.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

class VerbDetailsPresenter: VerbDetailsPresenterProtocol {
    
    weak var view: VerbDetailsViewProtocol!
    var interactor: VerbDetailsInteractorProtocol!
    var router: VerbDetailsRouterProtocol!
    
    init(view: VerbDetailsViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        view.setInfinitiveForm(with: interactor.infinitiveForm)
        view.setPastSimpleForm(with: interactor.pastSimpleForm)
        view.setPastParticipleForm(with: interactor.pastParticipleForm)
        
        view.setInfinitiveTranscription(with: interactor.infinitiveTranscription)
        view.setPastSimpleTranscription(with: interactor.pastSimpleTranscription)
        view.setPastParticipleTranscription(with: interactor.pastParticipleTranscription)
        
        view.setTranslation(with: interactor.translation)
        
        view.setRightAnswersToday(with: String(interactor.rightAnswersToday))
        view.setWrongAnswersToday(with: String(interactor.wrongAnswersToday))
        view.setRightAnswersForAllTime(with: String(interactor.rightAnswersForAllTime))
        view.setWrongAnswersForAllTime(with: String(interactor.wrongAnswersForAllTime))
    }
    
    func dismissDetailsView() {
        router.closeCurrentViewController()
    }
    
    // MARK: - Speech
    func infinitiveSpeechButtonClicked() {
        interactor.activateInfinitiveSpeech()
    }
    
    func pastSimpleSpeechButtonClicked() {
        interactor.activatePastSimpleSpeech()
    }
    
    func pastParticipleSpeechButtonClicked() {
        interactor.activatePastParticipleSpeech()
    }
}
