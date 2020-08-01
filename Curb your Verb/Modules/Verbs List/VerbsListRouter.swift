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
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "ShowDetail":
            guard let verbDetailsViewController = segue.destination as? VerbDetailsViewProtocol else {
                fatalError()
            }
            
            guard let selectedVerbCell = sender as? VerbTableViewCell else {
                fatalError()
            }
            
            guard let indexPath = tableViewController.tableView.indexPath(for: selectedVerbCell) else {
                fatalError()
            }
            
            //? add method to tableViewController get verb by indexPath
            // remove verb from cell
            // let selectedVerb = tableViewController.findVerb(by: indexPath)
            let selectedVerb = tableViewController.presenter.getVerb(at: indexPath)
            verbDetailsViewController.configure(verb: selectedVerb)
        default:
            fatalError()
        }
    }
}
