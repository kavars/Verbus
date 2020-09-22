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
        
        label.font = .systemFont(ofSize: 36)
        label.textAlignment = .center
        label.textColor = UIColor(named: "darkGreyColor")
        
        label.backgroundColor = .white
        
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 2
        
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
        
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
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
        
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
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
    
    let cellIdentifier = "verbCell"
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        collectionView.register(VerbCollectionCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView.isScrollEnabled = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.backgroundColor = nil
        
        return collectionView
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
                
        return flowLayout
    }()
    
    let checkButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.backgroundColor = UIColor(named: "darkRedColor")
        
        button.setTitle("Проверить", for: .normal)
        button.setTitleColor(.white, for: .normal)

        button.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        
        return button
    }()
    
    let gestureRecognizer: UISwipeGestureRecognizer = {
        let gestureRecognizer = UISwipeGestureRecognizer()
                
        gestureRecognizer.direction = .left
                
        return gestureRecognizer
    }()
    
    var presenter: LearnPresenterProtocol!
    let configurator: LearnConfiguratorProtocol = LearnConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        presenter.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.updateStogeContext()
        presenter.updateView()
    }
    
    // MARK: - IBAction
    
    @objc func swiped() {
        let startPoint = self.gestureRecognizer.location(in: view)
        
        let width = view.frame.width / 3
        
        if (startPoint.x > view.frame.width - width) && self.gestureRecognizer.direction == .left {
            if self.gestureRecognizer.state == .ended {
                presenter.skipVerb()
            }
        }
    }
    
    @objc func checkButtonClicked() {
        presenter.checkButtonClicked()
    }
    
    // MARK: - LearnViewDelegate methods
    
    var isCheckButtonHidden: Bool {
        set {
            checkButton.isHidden = newValue
        }
        get {
            return checkButton.isHidden
        }
    }
    
    func reloadCollectionView() {
        self.collectionView.reloadData()
    }
    
    func setView() {
        self.view.backgroundColor = UIColor(named: "sandYellowColor")
    }
    
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
    
    func setSwipeRecognizer() {
        DispatchQueue.main.async {
            self.gestureRecognizer.addTarget(self, action: #selector(self.swiped))

            self.view.addGestureRecognizer(self.gestureRecognizer)
        }
    }
        
    func setCorrectIndicator(to: Int) {
        DispatchQueue.main.async {
            self.correctIndicatorView.changeCells(at: to)
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

            self.view.addSubview(self.collectionView)
            
            self.view.addSubview(self.checkButton)
        }
    }
    
    func addConstraints() {
        DispatchQueue.main.async {
            NSLayoutConstraint.activate([
                // Correct indicator
                self.correctIndicatorView.widthAnchor.constraint(equalToConstant: 219),
                self.correctIndicatorView.heightAnchor.constraint(equalToConstant: 10),
                self.correctIndicatorView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 25),
                self.correctIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                
                // Infinitive
                self.infinitiveLabel.topAnchor.constraint(lessThanOrEqualTo: self.correctIndicatorView.bottomAnchor, constant: 68), // less or equal
                self.infinitiveLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 22),
                self.infinitiveLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -22),
                self.infinitiveLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.14532),
                self.infinitiveLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                
                // Past forms
                self.answerHUIStackView.heightAnchor.constraint(equalTo: self.infinitiveLabel.heightAnchor, multiplier: 0.5),
                self.answerHUIStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.answerHUIStackView.topAnchor.constraint(equalTo: self.infinitiveLabel.bottomAnchor, constant: 23),
                self.answerHUIStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 22),
                self.answerHUIStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -22),
                
                self.pastSimpleLabel.widthAnchor.constraint(equalTo: self.pastParticipateLabel.widthAnchor),
                
                // Answers
                self.collectionView.topAnchor.constraint(greaterThanOrEqualTo: self.answerHUIStackView.bottomAnchor, constant: 20),
                self.collectionView.bottomAnchor.constraint(equalTo: self.checkButton.topAnchor, constant: -32),
                self.collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.collectionView.heightAnchor.constraint(equalTo: self.collectionView.widthAnchor, multiplier: 2/3),
                self.collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.88),
                
                // Button
                self.checkButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.0406404),
                self.checkButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.352),
                self.checkButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -39),
                self.checkButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
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

extension LearnViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.variantsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! VerbCollectionCell
                
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 3 - 7
        let height = width
        
        return CGSize(width: width, height: height)
    }
}
