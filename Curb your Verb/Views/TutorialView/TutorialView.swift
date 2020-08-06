//
//  TutorialView.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 06.08.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit

class TutorialView: UIView {
    
    let kCONTENT_XIB_NAME = "TutorialView"
    lazy var settingsService: SettingsServiceProtocol = SettingsService()
    
    @IBOutlet weak var tapRecognizer: UITapGestureRecognizer!
    
    @IBOutlet var contentView: UIView!

    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        
        settingsService.isTutorial = false
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

extension UIView {
    func fixInView(_ container: UIView!) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        container.addSubview(self)
    }
}
