//
//  VerbsListRouter.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation
import UIKit

class VerbsListRouter: VerbsListRouterProtocol {
    weak var tableViewController: VerbsListTableViewController!
    
    init(tableViewController: VerbsListTableViewController) {
        self.tableViewController = tableViewController
    }
    
    func pushDetailView(at indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let verbDetailVCStoryboardId = "verbDetailVC"
        let verbDetailVC = storyboard.instantiateViewController(withIdentifier: verbDetailVCStoryboardId) as! VerbDetailsViewController
        
        let selectedVerb = self.tableViewController.presenter.getVerb(at: indexPath)
        verbDetailVC.configure(verb: selectedVerb)
        
        self.tableViewController.navigationController?.pushViewController(verbDetailVC, animated: true)
    }
}
