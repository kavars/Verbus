//
//  VerbCollectionCell.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 24.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit

protocol VerbCollectionCellProtocol: class {
    var isPressed: Bool { set get }
    var text: String? { set get }
    var bgColor: UIColor? { set get }
}

class VerbCollectionCell: UICollectionViewCell, VerbCollectionCellProtocol {
    let variant: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 17)
        label.textColor = UIColor(named: "darkGreyColor")
        
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(variant)
        
        NSLayoutConstraint.activate([
            self.variant.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.variant.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
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
