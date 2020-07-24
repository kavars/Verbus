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
    
    @IBOutlet weak var infinitive: UILabel!
    @IBOutlet weak var translate: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellView(infinitive: String?, translate: String?) {
        DispatchQueue.main.async {
            self.infinitive.text = infinitive
            self.translate.text  = translate
        }
    }
}
