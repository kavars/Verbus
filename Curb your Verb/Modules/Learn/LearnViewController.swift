//
//  LearnViewController.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit

class LearnViewController: UIViewController, LearnViewProtocol {

    let infinitiveLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 38)
        label.textAlignment = .center
        label.textColor = UIColor(named: "darkGreyColor")
        
        label.backgroundColor = .white
        
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let pastSimpleLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        label.textColor = UIColor(named: "darkGreyColor")
        
        label.backgroundColor = .white
        
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let pastParticipateLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        label.textColor = UIColor(named: "darkGreyColor")
        
        label.backgroundColor = .white
        
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let answerHUIStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        stackView.spacing = 30
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    
    let correctIndicatorView: CorrectIndicatorView = CorrectIndicatorView()
    
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
        
        let width = view.frame.width / 3
        
        if (startPoint.x > view.frame.width - width) && sender.direction == .left {
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
    
    func setSwipeRecognizerDirection() {
        DispatchQueue.main.async {
            self.gestureRecognizer.direction = .left
        }
    }
    
    func setCheckButton() {
        DispatchQueue.main.async {
            self.checkButton.layer.cornerRadius = 10
            
            self.infinitiveLabel.layer.masksToBounds = true
            self.pastSimpleLabel.layer.masksToBounds = true
            self.pastParticipateLabel.layer.masksToBounds = true
            
            self.infinitiveLabel.layer.cornerRadius = 10
            self.pastSimpleLabel.layer.cornerRadius = 10
            self.pastParticipateLabel.layer.cornerRadius = 10
        }
    }
    
    func setCollectionViewDelegate() {
        DispatchQueue.main.async {
            self.collectionView.delegate = self
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
    
    //
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
    
    func addElementsOnView() {
        DispatchQueue.main.async {
            self.correctIndicatorView.cellCount = 6
            self.correctIndicatorView.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(self.correctIndicatorView)
            
            self.view.addSubview(self.infinitiveLabel)
            
            self.answerHUIStackView.addArrangedSubview(self.pastSimpleLabel)
            self.answerHUIStackView.addArrangedSubview(self.pastParticipateLabel)
            
            self.view.addSubview(self.answerHUIStackView)
        }
    }
    
    func addConstraints() {
        DispatchQueue.main.async {
            NSLayoutConstraint.activate([
                self.correctIndicatorView.widthAnchor.constraint(equalToConstant: 219),
                self.correctIndicatorView.heightAnchor.constraint(equalToConstant: 10),
                self.correctIndicatorView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 25),
                self.correctIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                
                self.infinitiveLabel.topAnchor.constraint(equalTo: self.correctIndicatorView.bottomAnchor, constant: 68), // less or equal
                self.infinitiveLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 22),
                self.infinitiveLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -22),
                self.infinitiveLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.14532),
                self.infinitiveLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                
                self.answerHUIStackView.heightAnchor.constraint(equalTo: self.infinitiveLabel.heightAnchor, multiplier: 0.5),
                self.answerHUIStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.answerHUIStackView.topAnchor.constraint(equalTo: self.infinitiveLabel.bottomAnchor, constant: 23),
                self.answerHUIStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 22),
                self.answerHUIStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -22),
                
                self.pastSimpleLabel.widthAnchor.constraint(equalTo: self.pastParticipateLabel.widthAnchor)
            ])
        }
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
                
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        
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
