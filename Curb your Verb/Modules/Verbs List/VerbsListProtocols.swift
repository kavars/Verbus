//
//  VerbsListProtocols.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation
import UIKit

protocol VerbsListTableViewProtocol: class {
    
}

protocol VerbsListInteractorProtocol: class {
    func updateVerbs()
    
    func getVerbsCount() -> Int
    func getVerb(at index: Int) -> Verb
    
    func searchVerbs(infinitive: String)
    
    func getOnLearningVerbsIndexs() -> [IndexPath]
    
    func applySelectedToLearn(_ indexes: [IndexPath])
}

protocol VerbsListPresenterProtocol: class {
    var router: VerbsListRouterProtocol! { set get }
    
    func configureView()
    
    func updateVerbs()
    
    func getVerbsCount() -> Int
    func getVerb(at index: Int) -> Verb
    
    func searchVerbs(infinitive: String)
    
    func getOnLearningVerbsIndexs() -> [IndexPath]
    
    func applySelectedToLearn(_ indexes: [IndexPath])
}

protocol VerbsListConfiguratorProtocol: class {
    func configure(with tableViewController: VerbsListTableViewController)
}

protocol VerbsListRouterProtocol: class {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}
