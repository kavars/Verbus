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
    
    var cellCount: Int = 6 {
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
        distribution = .fillEqually
        alignment = .fill
        spacing = 1
        
        for cell in cells {
            removeArrangedSubview(cell)
            cell.removeFromSuperview()
        }
        
        cells.removeAll()
                
        for _ in 0..<cellCount {
            let cell = UIView()
            
            cell.backgroundColor = .white
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor(named: "borderGreyColor")?.cgColor
            
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 3
                        
            addArrangedSubview(cell)
            
            cells.append(cell)
            
        }
        
    }
    
    func changeCells(at index: Int) {
        for cell in cells {
            cell.backgroundColor = .white
            cell.layer.borderColor = UIColor(named: "borderGreyColor")?.cgColor
        }
        
        for i in 0..<index {
            let cell = cells[i]

            cell.backgroundColor = UIColor(named: "darkRedColor")
            cell.layer.borderColor = UIColor(named: "darkRedColor")?.cgColor
        }
    }
}
