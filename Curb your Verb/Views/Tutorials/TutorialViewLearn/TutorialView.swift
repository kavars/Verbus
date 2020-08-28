//
//  TutorialView.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 06.08.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit

final class TutorialView: UIView {
    
    lazy var settingsService: SettingsServiceProtocol = SettingsService()
    
    // MARK: - Labels & Image
    let indicatorInfoLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        
        label.text = "Индикатор ежедневных правильных ответов"
        
        return label
    }()
    
    let swipeInfoLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        
        label.text = "Свайп, что бы пропустить слово"
        
        return label
    }()
    
    let tapToContinueInfoLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .center
        
        label.text = "Нажать для продолжения"
        
        return label
    }()
    
    let swipeArrowImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
                
        imageView.image = UIImage(systemName: "arrow.left")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        
        return imageView
    }()
    
    // MARK: - Gesture action
    
    @objc func tapped() {
        settingsService.isTutorial = false
        self.removeFromSuperview()
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        
        gesture.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(gesture)
        
        backgroundColor = UIColor.darkGray.withAlphaComponent(0.85)
        
        setupViewLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        addSubview(indicatorInfoLabel)
        addSubview(swipeInfoLabel)
        addSubview(tapToContinueInfoLabel)
        addSubview(swipeArrowImageView)
        
        indicatorInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        swipeInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        tapToContinueInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        swipeArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            indicatorInfoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorInfoLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            indicatorInfoLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            
            swipeInfoLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            swipeInfoLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            swipeInfoLabel.widthAnchor.constraint(equalToConstant: 150),
            
            tapToContinueInfoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            tapToContinueInfoLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -120),
            tapToContinueInfoLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            
            swipeArrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            swipeArrowImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            swipeArrowImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
            swipeArrowImageView.trailingAnchor.constraint(equalTo: swipeInfoLabel.leadingAnchor)
        ])
    }
}
