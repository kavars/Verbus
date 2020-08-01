//
//  LearnInteractor.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

class LearnInteractor: LearnInteractorProtocol {
    
    weak var presenter: LearnPresenterProtocol!
    
    let settingsService: SettingsServiceProtocol = SettingsService()
        
    var user: UserProtocol = User()
    
    init(presenter: LearnPresenterProtocol) {
        self.presenter = presenter
    }
    
    var variantsCount: Int {
        get {
            return user.getVariantsCount()
        }
    }
    
    var variants: [String] {
        get {
            return user.getVariants()
        }
    }
    
    var infinitiveForm: String {
        get {
            return user.getInfinitive()
        }
    }
    
    var pastSimpleCheck: Bool = true
    var pastParticipleCheck: Bool = true
    
    var pastSimpleIndex: IndexPath = IndexPath()
    var pastParticipleIndex: IndexPath = IndexPath()
    
    var pastSimpleAnswer: String = ""
    
    var pastParticipleAnswer: String = ""
    
    func checkAnswer() {
        if user.getPastSimple() == pastSimpleAnswer && user.getPastParticiple() == pastParticipleAnswer {
            
            if settingsService.isVibration {
                presenter.successVibration()
            }
            
            user.rightAswer()
            
            presenter.changeCorrectIndicator(to: user.getIndicatorCount())
            
            // choose another verb
            user.nextVerb()
            
            presenter.resetView()
        } else {
            if settingsService.isVibration {
                presenter.unsuccessVibration()
            }
            
            presenter.errorAnimate()
            
            user.wrongAnswer()
            
            presenter.changeCorrectIndicator(to: user.getIndicatorCount())
        }
        
    }
    
    func skipVerb() {
        user.nextVerb()
        presenter.resetView()
    }
    
    var correctIndex: Int {
        get {
            return user.getIndicatorCount()
        }
    }
    
    func updateStogeContext() {
        user.updateStogeContext()
    }
}
