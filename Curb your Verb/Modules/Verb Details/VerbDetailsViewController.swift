//
//  VerbDetailsViewController.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit
import AVFoundation

class VerbDetailsViewController: UIViewController, VerbDetailsViewProtocol {
    
    // MARK: - Outlets
    
    let infinitive: UILabel = createUILabel()
    let pastSimple: UILabel = createUILabel()
    let pastParticiple: UILabel = createUILabel()
    
    let infinitiveTranscription: UILabel = createUILabel()
    let pastSimpleTranscription: UILabel = createUILabel()
    let pastParticipleTranscription: UILabel = createUILabel()
    
    let translation: UILabel = createUILabel()
    
    let rightAnswersToday: UILabel = {
        let label = createUILabel()
        label.textAlignment = .right
        
        return label
    }()
    let wrongAnswersToday: UILabel = {
        let label = createUILabel()
        label.textAlignment = .right
        
        return label
    }()
    let rightAnswersForAllTime: UILabel = {
        let label = createUILabel()
        label.textAlignment = .right
        
        return label
    }()
    let wrongAnswersForAllTime: UILabel = {
        let label = createUILabel()
        label.textAlignment = .right
        
        return label
    }()
    
    let rightLabel: UILabel = {
        let label = createUILabel()
        
        label.text = "Правильно"
        
        return label
    }()
    
    let wrongLabel: UILabel = {
        let label = createUILabel()
        
        label.text = "Неправильно"
        
        return label
    }()
    
    let rightView: UIView = createUIView()
    let wrongView: UIView = createUIView()
    
    let todayRightLabel: UILabel = {
        let label = createUILabel()
        
        label.textAlignment = .left
        label.text = "Сегодня"
        
        return label
    }()
    
    let allRightLabel: UILabel = {
        let label = createUILabel()
        
        label.textAlignment = .left
        label.text = "Всего"
        
        return label
    }()
    
    let todayWrongLabel: UILabel = {
        let label = createUILabel()
        
        label.textAlignment = .left
        label.text = "Сегодня"
        
        return label
    }()
    
    let allWrongLabel: UILabel = {
        let label = createUILabel()
        
        label.textAlignment = .left
        label.text = "Всего"
        
        return label
    }()
    
    let infinitiveSpeechButton: UIButton = {
        let button = createUIButton()
        
        button.addTarget(self, action: #selector(speechInfinitiveClicked), for: .touchUpInside)
        
        return button
    }()
    
    let pastSimpleSpeechButton: UIButton = {
        let button = createUIButton()
        
        button.addTarget(self, action: #selector(speechPastSimpleClicked), for: .touchUpInside)

        return button
    }()
    
    let pastParticipleSpeechButton: UIButton = {
        let button = createUIButton()
        
        button.addTarget(self, action: #selector(speechPastParticipleClicked), for: .touchUpInside)

        return button
    }()
    
    // MARK: - Actions
    
    @objc func speechInfinitiveClicked() {
        presenter.infinitiveSpeechButtonClicked()
    }
    
    @objc func speechPastSimpleClicked() {
        presenter.pastSimpleSpeechButtonClicked()
    }
    
    @objc func speechPastParticipleClicked() {
        presenter.pastParticipleSpeechButtonClicked()
    }
    
    
    var presenter: VerbDetailsPresenterProtocol!
    let configurator: VerbDetailsConfiguratorProtocol = VerbDetailsConfigurator()
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.configureView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter.dismissDetailsView()
    }
    
    func configure(verb: Verb) {
        configurator.configure(with: self, verb: verb)
    }
    
    // MARK: - VerbDetailsViewProtocol
    
    private func setUpCornerRadius(in view: UIView, with radius: CGFloat) {
        view.layer.masksToBounds = true
        view.layer.cornerRadius = radius
    }
    
    func setCellsView() {
        let cornerR: CGFloat = 10
        
        setUpCornerRadius(in: infinitive, with: cornerR)
        setUpCornerRadius(in: pastSimple, with: cornerR)
        setUpCornerRadius(in: pastParticiple, with: cornerR)

        setUpCornerRadius(in: infinitiveTranscription, with: cornerR)
        setUpCornerRadius(in: pastSimpleTranscription, with: cornerR)
        setUpCornerRadius(in: pastParticipleTranscription, with: cornerR)
        
        setUpCornerRadius(in: translation, with: cornerR)
        
        setUpCornerRadius(in: rightLabel, with: cornerR)
        setUpCornerRadius(in: wrongLabel, with: cornerR)
        setUpCornerRadius(in: rightView, with: cornerR)
        setUpCornerRadius(in: wrongView, with: cornerR)
    }
    
    func setInfinitiveForm(with string: String) {
        DispatchQueue.main.async {
            self.infinitive.text = string
        }
    }
    
    func setPastSimpleForm(with string: String) {
        DispatchQueue.main.async {
            self.pastSimple.text = string
        }
    }
    
    func setPastParticipleForm(with string: String) {
        DispatchQueue.main.async {
            self.pastParticiple.text = string
        }
    }
    
    func setInfinitiveTranscription(with string: String) {
        DispatchQueue.main.async {
            self.infinitiveTranscription.text = string
        }
    }
    
    func setPastSimpleTranscription(with string: String) {
        DispatchQueue.main.async {
            self.pastSimpleTranscription.text = string
        }
    }
    
    func setPastParticipleTranscription(with string: String) {
        DispatchQueue.main.async {
            self.pastParticipleTranscription.text = string
        }
    }
    
    func setTranslation(with string: String) {
        DispatchQueue.main.async {
            self.translation.text = string
        }
    }
    
    func setRightAnswersToday(with string: String) {
        DispatchQueue.main.async {
            self.rightAnswersToday.text = string
        }
    }
    
    func setWrongAnswersToday(with string: String) {
        DispatchQueue.main.async {
            self.wrongAnswersToday.text = string
        }
        
    }
    
    func setRightAnswersForAllTime(with string: String) {
        DispatchQueue.main.async {
            self.rightAnswersForAllTime.text = string
        }
    }
    
    func setWrongAnswersForAllTime(with string: String) {
        DispatchQueue.main.async {
            self.wrongAnswersForAllTime.text = string
        }
    }
    
    // setup UI
    func buildConstraints() {
        DispatchQueue.main.async {
            NSLayoutConstraint.activate([
                // Block with verbs & buttons
                self.infinitive.heightAnchor.constraint(equalTo: self.infinitive.widthAnchor, multiplier: 1.0),
                self.pastSimple.heightAnchor.constraint(equalTo: self.pastSimple.widthAnchor, multiplier: 1.0),
                self.pastParticiple.heightAnchor.constraint(equalTo: self.pastParticiple.widthAnchor, multiplier: 1.0),
                
                self.infinitiveTranscription.heightAnchor.constraint(equalTo: self.infinitiveTranscription.widthAnchor, multiplier: 1.0),
                self.pastSimpleTranscription.heightAnchor.constraint(equalTo: self.pastSimpleTranscription.widthAnchor, multiplier: 1.0),
                self.pastParticipleTranscription.heightAnchor.constraint(equalTo: self.pastParticipleTranscription.widthAnchor, multiplier: 1.0),
                
                self.infinitiveSpeechButton.heightAnchor.constraint(equalTo: self.infinitiveSpeechButton.widthAnchor, multiplier: 1.0/3.0),
                self.pastSimpleSpeechButton.heightAnchor.constraint(equalTo: self.pastSimpleSpeechButton.widthAnchor, multiplier: 1.0/3.0),
                self.pastParticipleSpeechButton.heightAnchor.constraint(equalTo: self.pastParticipleSpeechButton.widthAnchor, multiplier: 1.0/3.0),
                
                
                self.verbStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.verbStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
                self.verbStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                self.verbStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
                
                // Translation
                
                self.verbStackView.bottomAnchor.constraint(equalTo: self.translation.topAnchor, constant: -24),
                self.translation.centerXAnchor.constraint(equalTo: self.verbStackView.centerXAnchor),
                self.translation.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.067734),
                self.translation.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.538667),
                
                // Block with stats
                self.todayRightLabel.widthAnchor.constraint(equalTo: self.allRightLabel.widthAnchor),
                self.todayWrongLabel.widthAnchor.constraint(equalTo: self.allWrongLabel.widthAnchor),
                self.todayRightLabel.widthAnchor.constraint(equalTo: self.todayWrongLabel.widthAnchor),
                
                self.vRightAnswerView.topAnchor.constraint(equalTo: self.rightView.topAnchor, constant: 8),
                self.vRightAnswerView.leadingAnchor.constraint(equalTo: self.rightView.leadingAnchor, constant: 8),
                self.vRightAnswerView.trailingAnchor.constraint(equalTo: self.rightView.trailingAnchor, constant: -8),
                self.vRightAnswerView.bottomAnchor.constraint(equalTo: self.rightView.bottomAnchor, constant: -8),

                self.rightLabel.heightAnchor.constraint(equalToConstant: 30),
                self.wrongLabel.heightAnchor.constraint(equalTo: self.rightLabel.heightAnchor),

                self.vWrongAnswerView.topAnchor.constraint(equalTo: self.wrongView.topAnchor, constant: 8),
                self.vWrongAnswerView.leadingAnchor.constraint(equalTo: self.wrongView.leadingAnchor, constant: 8),
                self.vWrongAnswerView.trailingAnchor.constraint(equalTo: self.wrongView.trailingAnchor, constant: -8),
                self.vWrongAnswerView.bottomAnchor.constraint(equalTo: self.wrongView.bottomAnchor, constant: -8),

                self.vRightAnswerView.widthAnchor.constraint(equalTo: self.vWrongAnswerView.widthAnchor),
                self.vRightAnswerView.heightAnchor.constraint(equalTo: self.vWrongAnswerView.heightAnchor),

                self.hAnswerBlock.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.hAnswerBlock.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                self.hAnswerBlock.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                self.hAnswerBlock.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
            ])
        }
    }
    
    var vRightAnswerView: UIStackView!
    var vWrongAnswerView: UIStackView!
    var hAnswerBlock: UIStackView!
    
    var verbStackView: UIStackView!
    
    func addElementsOnViewController() {
        DispatchQueue.main.async {
            
            // Verb block
            let formStackView = UIStackView()
            formStackView.axis = .horizontal
            formStackView.alignment = .top
            formStackView.distribution = .fill
            formStackView.spacing = 8
            formStackView.translatesAutoresizingMaskIntoConstraints = false
            
            formStackView.addArrangedSubview(self.infinitive)
            formStackView.addArrangedSubview(self.pastSimple)
            formStackView.addArrangedSubview(self.pastParticiple)
            
            let transcriptionStackView = UIStackView()
            transcriptionStackView.axis = .horizontal
            transcriptionStackView.alignment = .top
            transcriptionStackView.distribution = .fill
            transcriptionStackView.spacing = 8
            transcriptionStackView.translatesAutoresizingMaskIntoConstraints = false

            transcriptionStackView.addArrangedSubview(self.infinitiveTranscription)
            transcriptionStackView.addArrangedSubview(self.pastSimpleTranscription)
            transcriptionStackView.addArrangedSubview(self.pastParticipleTranscription)

            let verbFormsStackView = UIStackView()
            verbFormsStackView.axis = .vertical
            verbFormsStackView.alignment = .fill
            verbFormsStackView.distribution = .fill
            verbFormsStackView.spacing = 8
            verbFormsStackView.translatesAutoresizingMaskIntoConstraints = false

            verbFormsStackView.addArrangedSubview(formStackView)
            verbFormsStackView.addArrangedSubview(transcriptionStackView)
            
            let speechStackView = UIStackView()
            speechStackView.axis = .horizontal
            speechStackView.alignment = .fill
            speechStackView.distribution = .fill
            speechStackView.spacing = 8
            speechStackView.addArrangedSubview(self.infinitiveSpeechButton)
            speechStackView.addArrangedSubview(self.pastSimpleSpeechButton)
            speechStackView.addArrangedSubview(self.pastParticipleSpeechButton)
            speechStackView.translatesAutoresizingMaskIntoConstraints = false

            self.verbStackView = UIStackView()
            self.verbStackView.axis = .vertical
            self.verbStackView.alignment = .fill
            self.verbStackView.distribution = .fill
            self.verbStackView.spacing = 20
            self.verbStackView.translatesAutoresizingMaskIntoConstraints = false

            self.verbStackView.addArrangedSubview(verbFormsStackView)
            self.verbStackView.addArrangedSubview(speechStackView)
            
            self.view.addSubview(self.verbStackView)
            
            // translation
            self.view.addSubview(self.translation)
            
            // right block
            
            let hTodayRight = UIStackView()
            hTodayRight.axis = .horizontal
            hTodayRight.alignment = .fill
            hTodayRight.distribution = .fill
            hTodayRight.spacing = 8
            hTodayRight.translatesAutoresizingMaskIntoConstraints = false
            
            hTodayRight.addArrangedSubview(self.todayRightLabel)
            hTodayRight.addArrangedSubview(self.rightAnswersToday)
            
            let hAllRight = UIStackView()
            hAllRight.axis = .horizontal
            hAllRight.alignment = .fill
            hAllRight.distribution = .fill
            hAllRight.spacing = 8
            hAllRight.translatesAutoresizingMaskIntoConstraints = false
            
            hAllRight.addArrangedSubview(self.allRightLabel)
            hAllRight.addArrangedSubview(self.rightAnswersForAllTime)
            
            self.vRightAnswerView = UIStackView()
            self.vRightAnswerView.axis = .vertical
            self.vRightAnswerView.alignment = .fill
            self.vRightAnswerView.distribution = .fill
            self.vRightAnswerView.spacing = 8
            self.vRightAnswerView.translatesAutoresizingMaskIntoConstraints = false

            self.vRightAnswerView.addArrangedSubview(hTodayRight)
            self.vRightAnswerView.addArrangedSubview(hAllRight)
            


            self.rightView.addSubview(self.vRightAnswerView)

            


            let vRightBlock = UIStackView()
            vRightBlock.axis = .vertical
            vRightBlock.alignment = .fill
            vRightBlock.distribution = .fill
            vRightBlock.spacing = 8
            vRightBlock.translatesAutoresizingMaskIntoConstraints = false

            vRightBlock.addArrangedSubview(self.rightLabel)
            vRightBlock.addArrangedSubview(self.rightView)

            // right block end
            // wrong block

            let hTodayWrong = UIStackView()
            hTodayWrong.axis = .horizontal
            hTodayWrong.alignment = .fill
            hTodayWrong.distribution = .fill
            hTodayWrong.spacing = 8
            hTodayWrong.translatesAutoresizingMaskIntoConstraints = false

            hTodayWrong.addArrangedSubview(self.todayWrongLabel)
            hTodayWrong.addArrangedSubview(self.wrongAnswersToday)

            let hAllWrong = UIStackView()
            hAllWrong.axis = .horizontal
            hAllWrong.alignment = .fill
            hAllWrong.distribution = .fill
            hAllWrong.spacing = 8
            hAllWrong.translatesAutoresizingMaskIntoConstraints = false

            hAllWrong.addArrangedSubview(self.allWrongLabel)
            hAllWrong.addArrangedSubview(self.wrongAnswersForAllTime)

            self.vWrongAnswerView = UIStackView()
            self.vWrongAnswerView.axis = .vertical
            self.vWrongAnswerView.alignment = .fill
            self.vWrongAnswerView.distribution = .fill
            self.vWrongAnswerView.spacing = 8
            self.vWrongAnswerView.translatesAutoresizingMaskIntoConstraints = false

            self.vWrongAnswerView.addArrangedSubview(hTodayWrong)
            self.vWrongAnswerView.addArrangedSubview(hAllWrong)

            self.wrongView.addSubview(self.vWrongAnswerView)



            let vWrongBlock = UIStackView()
            vWrongBlock.axis = .vertical
            vWrongBlock.alignment = .fill
            vWrongBlock.distribution = .fill
            vWrongBlock.spacing = 8
            vWrongBlock.translatesAutoresizingMaskIntoConstraints = false

            vWrongBlock.addArrangedSubview(self.wrongLabel)
            vWrongBlock.addArrangedSubview(self.wrongView)

            // wrong block end
            // Answer block

            self.hAnswerBlock = UIStackView()
            self.hAnswerBlock.axis = .horizontal
            self.hAnswerBlock.alignment = .fill
            self.hAnswerBlock.distribution = .fill
            self.hAnswerBlock.spacing = 50
            self.hAnswerBlock.translatesAutoresizingMaskIntoConstraints = false

            self.hAnswerBlock.addArrangedSubview(vRightBlock)
            self.hAnswerBlock.addArrangedSubview(vWrongBlock)
            // Answer block end

            self.hAnswerBlock.backgroundColor = .white

            self.view.addSubview(self.hAnswerBlock)

        }
    }
}

// MARK: - Helper methods
extension VerbDetailsViewController {
    static private func createUILabel() -> UILabel {
         let label = UILabel()
                 
         label.font = .systemFont(ofSize: 17)
         label.textColor = UIColor(named: "darkGreyColor")
         
         label.textAlignment = .center
         label.backgroundColor = .white
         
         label.translatesAutoresizingMaskIntoConstraints = false
         
         return label
     }
     
     static private func createUIView() -> UIView {
         let view = UIView()
         
         view.backgroundColor = .white
         
         view.layer.masksToBounds = true
         view.layer.cornerRadius = 10
         
         view.translatesAutoresizingMaskIntoConstraints = false
         
         return view
     }
     
     static private func createUIButton() -> UIButton {
         let button = UIButton()
         
         button.setImage(UIImage(systemName: "speaker"), for: .normal)
         button.setImage(UIImage(systemName: "speaker.fill"), for: .highlighted)
         
         button.tintColor = UIColor(named: "darkRedColor")
         
         button.translatesAutoresizingMaskIntoConstraints = false
         
         return button
     }
}
