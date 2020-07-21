//
//  LearnPresenter.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

class LearnPresenter: LearnPresenterProtocol {
    
    weak var view: LearnViewProtocol!
    var interactor: LearnInteractorProtocol!
    var router: LearnRouterProtocol!
    
    weak var correctIndicatorView: CorrectIndicatorViewProtocol?
    
    init(view: LearnViewProtocol) {
        self.view = view
    }
    
    // MARK: - LearnPresenterProtocol methods
    
    var variantsCount: Int {
        get {
            return interactor.variantsCount
        }
    }
    
    var variants: [String] {
        get {
            return interactor.variants
        }
    }
    
    func configureView() {
        view.setInfinitiveForm(with: interactor.infinitiveForm)
        
        changeCorrectIndicator(to: interactor.correctIndex) // ?
    }
    
    // Work with cells
    var pastSimpleCheck: Bool {
        set {
            interactor.pastSimpleCheck = newValue
        }
        get {
            return interactor.pastSimpleCheck
        }
    }
    
    var pastParticipleCheck: Bool {
        set {
            interactor.pastParticipleCheck = newValue
        }
        get {
            return interactor.pastParticipleCheck
        }
    }
    
    func pastSimpleCellSelected(_ cell: VerbCellProtocol?, at indexPath: IndexPath) {
        if let cell = cell {
            cell.bgColor = Colors.yellowVariant
            cell.isPressed = true
            pastSimpleIndex = indexPath
            
            pastSimpleAnswer = cell.text ?? ""
            
            view.setPastSimpleForm(with: pastSimpleAnswer) // ?
            pastSimpleCheck = false
        }
    }
    
    func pastParticipleCellSetected(_ cell: VerbCellProtocol?, at indexPath: IndexPath) {
        if let cell = cell {
            cell.bgColor = Colors.yellowVariant
            cell.isPressed = true
            pastParticipleIndex = indexPath
            
            pastParticipleAnswer = cell.text ?? ""
            
            view.setPastParticipateForm(with: pastParticipleAnswer) // ?
            pastParticipleCheck = false
        }
    }
    
    func selectedPressedCell(_ cell: VerbCellProtocol?, at indexPath: IndexPath) {
        if let cell = cell {
            cell.bgColor = Colors.grayVariant
            cell.isPressed = false
            
            if indexPath == pastSimpleIndex {
                view.setPastSimpleForm(with: "__________")
                pastSimpleCheck = true
            } else if indexPath == pastParticipleIndex {
                view.setPastParticipateForm(with: "__________")
                pastParticipleCheck = true
            }
        }
    }
    
    var pastSimpleIndex: IndexPath {
        set {
            interactor.pastSimpleIndex = newValue
        }
        get {
            return interactor.pastSimpleIndex
        }
    }
    
    var pastParticipleIndex: IndexPath {
        set {
            interactor.pastParticipleIndex = newValue
        }
        get {
            return interactor.pastParticipleIndex
        }
    }
    
    var pastSimpleAnswer: String {
        set {
            interactor.pastSimpleAnswer = newValue
        }
        get {
            return interactor.pastSimpleAnswer
        }
    }
    
    var pastParticipleAnswer: String {
        set {
            interactor.pastParticipleAnswer = newValue
        }
        get {
            return interactor.pastParticipleAnswer
        }
    }
    
    func checkButtonClicked() {
        interactor.checkAnswer()
    }
    
    func resetView() {
        view.setInfinitiveForm(with: interactor.infinitiveForm)
        view.setPastSimpleForm(with: "__________")
        view.setPastParticipateForm(with: "__________")
        
        pastSimpleAnswer = "__________"
        pastParticipleAnswer = "__________"
        
        pastSimpleCheck = true
        pastParticipleCheck = true
        
        if let cellPS = view.getCell(at: pastSimpleIndex) {
            cellPS.bgColor = Colors.grayVariant
            cellPS.isPressed = false
        }
        
        if let cellPP = view.getCell(at: pastParticipleIndex) {
            cellPP.bgColor = Colors.grayVariant
            cellPP.isPressed = false
        }
        
        

        
        pastSimpleIndex = IndexPath()
        pastParticipleIndex = IndexPath()
        
        // load new variants
        if let cells = view.getVisibleCells() {
            for (index, cell) in cells.enumerated() {
                cell.text = interactor.variants[index]
            }
        }
        
        // update correct indicator
        changeCorrectIndicator(to: interactor.correctIndex)
    }
    
    func successVibration() {
        view.performSuccessVibration()
    }
    
    func unsuccessVibration() {
        view.performUnsuccessVibration()
    }
    
    func errorAnimate() {
        view.performErrorAnimate()
    }
    
    func changeCorrectIndicator(to: Int) {
        correctIndicatorView?.changeCells(at: to)
    }
    
    func updateStogeContext() {
        interactor.updateStogeContext()
        resetView()
    }
}
