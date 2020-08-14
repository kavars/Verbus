//
//  TutorialViewTable.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 13.08.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit

class TutorialViewTable: UIView {
    
    let kCONTENT_XIB_NAME = "TutorialViewTable"
    lazy var settingsService: SettingsServiceProtocol = SettingsService()
    
    @IBOutlet weak var tapRecognizer: UITapGestureRecognizer!
    
    @IBOutlet var contentView: UIView!

    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        
        settingsService.isTutorialTable = false
        self.removeFromSuperview()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    }
}
