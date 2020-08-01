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
    
    @IBOutlet weak var gestureRecognizer: UISwipeGestureRecognizer!
    
    var presenter: LearnPresenterProtocol!
    let configurator: LearnConfiguratorProtocol = LearnConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.updateStogeContext()
    }
    
    // MARK: - IBAction
    
    
    @IBAction func swiped(_ sender: UISwipeGestureRecognizer) {
        let startPoint = sender.location(in: view)
        
        if (startPoint.x > view.frame.width / 2) && sender.direction == .left {
            if sender.state == .ended {
                presenter.skipVerb()
            }
        }
        

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
    
    func getCell(at index: IndexPath) -> VerbCollectionCellProtocol? {
        if let cell = collectionView.cellForItem(at: index) as? VerbCollectionCellProtocol {
            return cell
        }
        return nil
    }
    
    func performErrorAnimate() {
        animate(label: infinitiveLabel)
    }
    
    func getVisibleCells() -> [VerbCollectionCellProtocol]? {
        return collectionView.visibleCells as? [VerbCollectionCellProtocol]
    }
    
    func setSwipeRecognizerDirection() {
        gestureRecognizer.direction = .left
    }
    
    func setCheckButton() {
        checkButton.layer.cornerRadius = 10
    }
    
    func setCollectionViewDelegate() {
        self.collectionView.delegate = self
    }
    
    // MARK: - Animation
    
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
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension LearnViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.variantsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "verbCell", for: indexPath) as! VerbCollectionCell
        
        cell.variant.lineBreakMode = .byWordWrapping
        cell.variant.numberOfLines = 0
        cell.variant.text = self.presenter.variants[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? VerbCollectionCellProtocol
        
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
