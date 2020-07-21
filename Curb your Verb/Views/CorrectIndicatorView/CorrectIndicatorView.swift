//
//  CorrectIndicatorView.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit

protocol CorrectIndicatorViewProtocol: class {
    func changeCells(at index: Int)
}

class CorrectIndicatorView: UIStackView, CorrectIndicatorViewProtocol {
    private var cells = [UIView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCells()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupCells()
    }
    
    private func setupCells() {
        axis = .horizontal
        distribution = Distribution.fillProportionally
        alignment = Alignment.center
        spacing = 1
        
        
        
        for _ in 0...5 {
            let cell = UIView()
            cell.heightAnchor.constraint(equalToConstant: 10).isActive = true
            cell.widthAnchor.constraint(equalToConstant: 20).isActive = true
            cell.backgroundColor = Colors.grayIndicator
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.white.cgColor
            
            addArrangedSubview(cell)
            cells.append(cell)
        }
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func changeCells(at index: Int) {
        for cell in cells {
            cell.backgroundColor = Colors.grayIndicator
        }
        
        for i in 0..<index {
            let cell = cells[i]

            cell.backgroundColor = Colors.greenIndicator
        }
    }
}
