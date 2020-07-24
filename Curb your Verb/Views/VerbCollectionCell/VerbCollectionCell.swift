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
    @IBOutlet weak var variant: UILabel!
    
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
