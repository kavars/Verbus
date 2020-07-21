//
//  VerbDetailsInteractor.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

class VerbDetailsInteractor: VerbDetailsInteractorProtocol {
    
    weak var presenter: VerbDetailsPresenterProtocol!
    
    var verb: Verb?
    
    init(presenter: VerbDetailsPresenterProtocol) {
        self.presenter = presenter
    }
    
    func setVerb(verb: Verb) {
        self.verb = verb
    }
    
    // MARK: - VerbDetailsInteractorProtocol
    
    var infinitiveForm: String {
        get {
            guard let infinitive = verb?.infinitive else {
                return ""
            }
            return infinitive
        }
    }
    
    var pastSimpleForm: String {
        get {
            guard let pastSimple = verb?.pastSimple else {
                return ""
            }
            return pastSimple
        }
    }
    
    var pastParticipleForm: String {
        get {
            guard let pastParticiple = verb?.pastParticiple else {
                return ""
            }
            return pastParticiple
        }
    }
    
    var infinitiveTranscription: String {
        get {
            guard let infinitiveTranscription = verb?.infinitiveTranscription else {
                return ""
            }
            return infinitiveTranscription
        }
    }
    
    var pastSimpleTranscription: String {
        get {
            guard let pastSimpleTranscription = verb?.pastSimpleTranscription else {
                return ""
            }
            return pastSimpleTranscription
        }
    }
    
    var pastParticipleTranscription: String {
        get {
            guard let pastParticipleTranscription = verb?.pastParticipleTranscription else {
                return ""
            }
            return pastParticipleTranscription
        }
    }
    
    var translation: String {
        get {
            guard let translation = verb?.translation else {
                return ""
            }
            return translation
        }
    }
    
    var rightAnswersToday: Int32 {
        get {
            guard let rightAnswersToday = verb?.progress?.rightAnswersToday else {
                return 0
            }
            return rightAnswersToday
        }
    }
    
    var wrongAnswersToday: Int32 {
        get {
            guard let wrongAnswersToday = verb?.progress?.wrongAnswersToday else {
                return 0
            }
            return wrongAnswersToday
        }
    }
    
    var rightAnswersForAllTime: Int32 {
        get {
            guard let rightAnswersForAllTime = verb?.progress?.rightAnswersForAllTime else {
                return 0
            }
            return rightAnswersForAllTime
        }
    }
    
    var wrongAnswersForAllTime: Int32 {
        get {
            guard let wrongAnswersForAllTime = verb?.progress?.wrongAnswersForAllTime else {
                return 0
            }
            return wrongAnswersForAllTime
        }
    }
}
