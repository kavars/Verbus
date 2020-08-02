//
//  User.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation
//import UIKit // ?

protocol UserProtocol: class {
    func nextVerb()
    func getVariants() -> [String]
    func getVariantsCount() -> Int
    func getInfinitive() -> String
    func getPastSimple() -> String
    func getPastParticiple() -> String
    
    func rightAswer()
    func wrongAnswer()
    
    func getIndicatorCount() -> Int
    
    func updateStogeContext()
}

class User: UserProtocol {
    
//    lazy var storeService: StoreServiceVerbsProtocol = {
//        guard let storeService = (UIApplication.shared.delegate as? AppDelegate)?.storeVerbService else {
//            fatalError()
//        }
//
//        return storeService
//    }() // StoreServiceCoreData(modelName: "Curb_your_Verb")
    lazy var storeService: StoreServiceVerbsProtocol = StoreServiceCoreData(modelName: "Curb_your_Verb")
    
    private var currentVerb: Verb?
    
    private var arrayWithVerbs: [Verb] = []
    
    private var variants: [String] = []
    
    func nextVerb() {
        if !arrayWithVerbs.isEmpty {
            currentVerb = arrayWithVerbs[Int.random(in: 0..<arrayWithVerbs.count)]
            
            guard let variants = currentVerb?.variants as? [String] else {
                return
            }
            
            self.variants = variants
        } else {
            // ?
            currentVerb = Verb(context: storeService.managedContext)
            currentVerb?.infinitive = "Нет выбранного глагола"
        }

    }
    
    init() {
        storeService.updateContext()
        
        if let verbs = storeService.verbsFetch(of: .onLearning) {
            arrayWithVerbs = verbs
        }
        
        nextVerb()
    }
    
    
    
    func getVariants() -> [String] {
        return variants
    }
    
    func getVariantsCount() -> Int {
        return variants.count
    }
    
    func getInfinitive() -> String {
        guard let inf = currentVerb?.infinitive else {
            return ""
        }
        
        return inf
    }
    
    func getPastSimple() -> String {
        guard let ps = currentVerb?.pastSimple else {
            return ""
        }
        
        return ps
    }
    
    func getPastParticiple() -> String {
        guard let pp = currentVerb?.pastParticiple else {
            return ""
        }
        
        return pp
    }
    
    func rightAswer() {
        currentVerb?.progress?.rightAnswersToday += 1
        currentVerb?.progress?.rightAnswersForAllTime += 1
                
        storeService.saveContext()
    }
    
    func wrongAnswer() {
        currentVerb?.progress?.wrongAnswersToday += 1
        currentVerb?.progress?.wrongAnswersForAllTime += 1
        
        storeService.saveContext()
    }
    
    func getIndicatorCount() -> Int {
        guard let progress = currentVerb?.progress else {
            return 0
        }
        
        let count = progress.rightAnswersToday - progress.wrongAnswersToday
                
        if count < 0 {
            return 0
        } else if count > 6 {
            return 6
        } else {
            return Int(count)
        }
    }
    
    func updateStogeContext() {
//        storeService = StoreServiceCoreData(modelName: "Curb_your_Verb")
        storeService.updateContext()
        
        if let verbs = storeService.verbsFetch(of: .onLearning) {
            arrayWithVerbs = verbs
        }
        
        nextVerb()
    }
}
