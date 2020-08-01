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
    func setUpSearchController()
    func setUpTableView()
    
    var isTableEditing: Bool { get }
    
    func startEditing()
    func selectVerb(at index: IndexPath)
    
    func endEditing()
    
    func updateList()
    
    var indexPathsForSelectedRows: [IndexPath]? { get }
    
    var searchText: String? { get }
    
    func toggleSearchController()
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
    
    func getVerbsCount() -> Int
    func getVerb(at index: Int) -> Verb
                
    func selectToLearnClicked()
    
    func viewWillAppear()
    
    func updateSearchResults()
}

protocol VerbsListConfiguratorProtocol: class {
    func configure(with tableViewController: VerbsListTableViewController)
}

protocol VerbsListRouterProtocol: class {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}
