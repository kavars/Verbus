//
//  LearnViewController.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit

class LearnViewController: UIViewController, LearnViewProtocol {

    @IBOutlet weak var infinitiveLabel: UILabel!
    @IBOutlet weak var pastSimpleLabel: UILabel!
    @IBOutlet weak var pastParticipateLabel: UILabel!
    
    @IBOutlet weak var correctIndicatorView: CorrectIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var checkButton: UIButton!
    
    
    var presenter: LearnPresenterProtocol!
    let configurator: LearnConfiguratorProtocol = LearnConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()
        
        self.collectionView.delegate = self
        
        checkButton.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.updateStogeContext()
    }

    @IBAction func checkButtonClicked(_ sender: UIButton) {
        presenter.checkButtonClicked()
    }
    
    // MARK: - LearnViewDelegate methods
    
    func setInfinitiveForm(with string: String) {
        DispatchQueue.main.async {
            self.infinitiveLabel.text = string
        }
    }
    
    func setPastSimpleForm(with string: String) {
        DispatchQueue.main.async {
            self.pastSimpleLabel.text = string
        }
    }
    
    func setPastParticipateForm(with string: String) {
        DispatchQueue.main.async {
            self.pastParticipateLabel.text = string
        }
    }
    
    // Vibration
    func performSuccessVibration() {
        let feedback = UINotificationFeedbackGenerator()
        feedback.notificationOccurred(.success)
    }
    
    func performUnsuccessVibration() {
        let feedback = UINotificationFeedbackGenerator()
        feedback.notificationOccurred(.error)
    }
    
    func getCell(at index: IndexPath) -> VerbCellProtocol? {
        if let cell = collectionView.cellForItem(at: index) as? VerbCellProtocol {
            return cell
        }
        return nil
    }
    
    func performErrorAnimate() {
        animate(label: infinitiveLabel)
    }
    
    // ?
    func animate(label: UILabel) {
        
        let changeColor = CATransition()
        
        changeColor.duration = 0.3
        changeColor.type = .fade
        changeColor.repeatCount = 3
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            label.layer.add(changeColor, forKey: nil)
            label.textColor = .black
        }
        label.textColor = .red
        CATransaction.commit()
    }
    
    func getVisibleCells() -> [VerbCellProtocol]? {
        return collectionView.visibleCells as? [VerbCellProtocol]
    }
}

// MARK: - Verb Cell

protocol VerbCellProtocol: class {
    var isPressed: Bool { set get }
    var text: String? { set get }
    var bgColor: UIColor? { set get }
}

class VerbCell: UICollectionViewCell, VerbCellProtocol {
    @IBOutlet weak var variant: UILabel!
    
    var isPressed = false
    
    var text: String? {
        set {
            variant.text = newValue
        }
        get {
            return variant.text
        }
    }
    
    var bgColor: UIColor? {
        set {
            self.backgroundColor = newValue
        }
        get {
            return self.backgroundColor
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension LearnViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.variantsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "verbCell", for: indexPath) as! VerbCell
        
        cell.variant.lineBreakMode = .byWordWrapping
        cell.variant.numberOfLines = 0
        cell.variant.text = self.presenter.variants[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? VerbCellProtocol
        
        if let isPressed = cell?.isPressed {
            if !isPressed {
                if presenter.pastSimpleCheck {
                    presenter.pastSimpleCellSelected(cell, at: indexPath)
                } else if presenter.pastParticipleCheck {
                    presenter.pastParticipleCellSetected(cell, at: indexPath)
                }
            } else {
                presenter.selectedPressedCell(cell, at: indexPath)
            }
        }
    }
}
