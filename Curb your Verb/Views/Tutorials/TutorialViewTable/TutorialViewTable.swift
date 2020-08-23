//
//  TutorialViewTable.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 13.08.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit

class TutorialViewTable: UIView {
    
    lazy var settingsService: SettingsServiceProtocol = SettingsService()

    // MARK: - Label

    let bookInfoLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 3
        
        label.text = "Нажми на книгу что бы добавить глаголы на обучение"
        
        return label
    }()
    
    // MARK: - Gesture action

    @objc func tapped() {
        settingsService.isTutorialTable = false
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
        addSubview(bookInfoLabel)
        
        bookInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bookInfoLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            bookInfoLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            bookInfoLabel.widthAnchor.constraint(equalToConstant: 180)
        ])
    }
}
