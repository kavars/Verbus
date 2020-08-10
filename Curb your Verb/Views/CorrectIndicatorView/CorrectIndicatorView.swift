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

@IBDesignable class CorrectIndicatorView: UIStackView, CorrectIndicatorViewProtocol {
    private var cells = [UIView]()
    
    @IBInspectable var cellCount: Int = 6 {
        didSet {
            setupCells()
        }
    }
    
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
        
        for cell in cells {
            removeArrangedSubview(cell)
            cell.removeFromSuperview()
        }
        
        cells.removeAll()
                
        for _ in 0..<cellCount {
            let cell = UIView()
            
            let cellSize = CGSize(width: frame.width / CGFloat(cellCount) - 1, height: frame.height)

            cell.backgroundColor = Colors.grayIndicator
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.white.cgColor
            
            cell.translatesAutoresizingMaskIntoConstraints = false
            cell.heightAnchor.constraint(equalToConstant: cellSize.height).isActive = true
            cell.widthAnchor.constraint(equalToConstant: cellSize.width).isActive = true
            
            addArrangedSubview(cell)
            cells.append(cell)
            
        }
        
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
