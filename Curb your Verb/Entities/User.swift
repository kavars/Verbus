//
//  User.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation

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
    
    lazy var storeService: StoreServiceVerbsProtocol = StoreServiceCoreData(modelName: "Curb_your_Verb")
    lazy var storeStrikeSerice: StoreStrikeServiceProtocol = StoreStrikeService()
    
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
        storeService.refreshContext()
        
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
        
        let strike = storeStrikeSerice.savedDailyStrike() + 1
        storeStrikeSerice.saveDailyStrike(with: strike)
                
        storeService.saveContext()
    }
    
    func wrongAnswer() {
        currentVerb?.progress?.wrongAnswersToday += 1
        currentVerb?.progress?.wrongAnswersForAllTime += 1
        
        let strike = storeStrikeSerice.savedDailyStrike() - 1
        storeStrikeSerice.saveDailyStrike(with: strike)
        
        storeService.saveContext()
    }
    
    func getIndicatorCount() -> Int {
        return storeStrikeSerice.savedDailyStrike()
    }
    
    func updateStogeContext() {
        storeService.refreshContext()
        
        if let verbs = storeService.verbsFetch(of: .onLearning) {
            arrayWithVerbs = verbs
        }
        
        nextVerb()
    }
}
