//
//  VerbTableViewCell.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 24.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit

protocol VerbTableViewCellProtocol: class {
    func configureCellView(infinitive: String?, translate: String?)
}

class VerbTableViewCell: UITableViewCell, VerbTableViewCellProtocol {
    
    let infinitive: UILabel = {
        let label = UILabel()
        
        label.backgroundColor = .white
        
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
                
        return label
    }()
    
    let translate: UILabel = {
        let label = UILabel()
        
        label.backgroundColor = .white
        
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        
        return label
    }()
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellView(infinitive: String?, translate: String?) {
        addSubview(self.infinitive)
        addSubview(self.translate)
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(named: "cellSelectedColor")
        selectedBackgroundView = bgColorView
        
        tintColor = UIColor(named: "darkRedColor")
        
        DispatchQueue.main.async {
            self.infinitive.text = infinitive
            self.translate.text  = translate
            
            self.infinitive.translatesAutoresizingMaskIntoConstraints = false
            self.translate.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                self.infinitive.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
                self.infinitive.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                self.infinitive.heightAnchor.constraint(equalToConstant: 35),
                self.infinitive.widthAnchor.constraint(equalToConstant: 110),
                
                self.translate.centerYAnchor.constraint(equalTo: self.infinitive.centerYAnchor),
                self.translate.leadingAnchor.constraint(equalTo: self.infinitive.trailingAnchor, constant: 8),
                self.translate.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                self.translate.heightAnchor.constraint(equalToConstant: 35)
            ])
        }
    }
}
