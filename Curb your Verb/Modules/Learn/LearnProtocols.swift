//
//  LearnProtocols.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

protocol LearnViewProtocol: class {
    func setView()
    
    func setInfinitiveForm(with string: String)
    func setPastSimpleForm(with string: String)
    func setPastParticipateForm(with string: String)
    
    func performSuccessVibration()
    func performUnsuccessVibration()
    
    func getCell(at index: IndexPath) -> VerbCollectionCellProtocol? // ?
    
    func performErrorAnimate()
    
    func getVisibleCells() -> [VerbCollectionCellProtocol]?
    
    func setSwipeRecognizer()
    
    func addElementsOnView()
    func addConstraints()
    
    func setCorrectIndicator(to: Int)
    
    var isCheckButtonHidden: Bool { set get }
    
    func reloadCollectionView()
}

protocol LearnInteractorProtocol: class {
    var variantsCount: Int { get }
    var variants: [String] { get }
    
    var infinitiveForm: String { get }
    
    var pastSimpleCheck: Bool { set get }
    var pastParticipleCheck: Bool { set get }
    
    var pastSimpleIndex: IndexPath { set get }
    var pastParticipleIndex: IndexPath { set get }
    
    var pastSimpleAnswer: String { set get }
    var pastParticipleAnswer: String { set get }
    
    func checkAnswer()
    
    var correctIndex: Int { get } //?
    
    func updateStogeContext()
    
    func skipVerb()
}

// MARK: - LearnPresenterProtocol
protocol LearnPresenterProtocol: class {
    var router: LearnRouterProtocol! { set get }
    
    func configureView()
    
    var variantsCount: Int { get }
    var variants: [String] { get }
    
    var pastSimpleCheck: Bool { set get }
    var pastParticipleCheck: Bool { set get }
    
    // change to protocol
    func pastSimpleCellSelected(_ cell: VerbCollectionCellProtocol?, at indexPath: IndexPath)
    func pastParticipleCellSetected(_ cell: VerbCollectionCellProtocol?, at indexPath: IndexPath)
    func selectedPressedCell(_ cell: VerbCollectionCellProtocol?, at indexPath: IndexPath)
    
    var pastSimpleIndex: IndexPath { set get }
    var pastParticipleIndex: IndexPath { set get }
    
    var pastSimpleAnswer: String { set get }
    var pastParticipleAnswer: String { set get }
    
    func checkButtonClicked()
    
    func resetView()
    
    func successVibration()
    func unsuccessVibration()
    
    func errorAnimate()
    
    func changeCorrectIndicator(to: Int)
    
    func updateStogeContext()
    
    func skipVerb()
    
    func updateView()
}

protocol LearnConfiguratorProtocol: class {
    func configure(with viewController: LearnViewController)
}

protocol LearnRouterProtocol: class {
    
}
