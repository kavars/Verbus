//
//  StoreSevice.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 09.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation
import CoreData

// MARK: - StoreServiceVerbs

protocol StoreServiceVerbsProtocol {
    func saveContext()
    
    var managedContext: NSManagedObjectContext { get }
    
    func verbsFetch() -> [Verb]?
    
    func verbsFetchAll() -> [Verb]?
    
    func verbsSearchInfinitiveFetch(infinitive: String) -> [Verb]?
}

class StoreServiceCoreData: StoreServiceVerbsProtocol {
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        return container
    }()
    
    func saveContext() {
        guard managedContext.hasChanges else {
            return
        }
        
        do {
            try managedContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func verbsFetch() -> [Verb]? {
        
        var verbs: [Verb] = []
        
        insertSampleData()

        
        let fetch: NSFetchRequest<Verb> = Verb.fetchRequest()
        fetch.predicate = NSPredicate(format: "%K == %@", argumentArray: [#keyPath(Verb.isLearn), true]
        )
        
        
        do {
            verbs = try self.managedContext.fetch(fetch)
            
            
            return verbs
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func verbsFetchAll() -> [Verb]? {
        var verbs: [Verb] = []
        
        insertSampleData()
        
        let fetch: NSFetchRequest<Verb> = Verb.fetchRequest()
        
        
        do {
            verbs = try self.managedContext.fetch(fetch)
            
            verbs.sort(by: {$0.infinitive! < $1.infinitive!})
            
            return verbs
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func verbsSearchInfinitiveFetch(infinitive: String) -> [Verb]? {
        
        var verbs: [Verb] = []
        
        insertSampleData()
        
        let fetch: NSFetchRequest<Verb> = Verb.fetchRequest()
        
        if !infinitive.isEmpty {
            fetch.predicate = NSPredicate(format: "%K CONTAINS[c] %@", argumentArray: [#keyPath(Verb.infinitive), infinitive]
            )
        }
        
        
        do {
            verbs = try self.managedContext.fetch(fetch)
            
            verbs.sort(by: {$0.infinitive! < $1.infinitive!})
            
            return verbs
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    // MARK: - Sample Verbs
    func insertSampleData() {
        
        let fetch: NSFetchRequest<Verb> = Verb.fetchRequest()
        
        let count = try! managedContext.count(for: fetch)
        
        if count > 0 {
            // SampleData.plist data already in CoreData
            return
        }
        
        let path = Bundle.main.path(forResource: "SampleData", ofType: "plist")
        let dataArra = NSArray(contentsOfFile: path!)
        
        let dataArray = dataArra!
        
        for dict in dataArray {
            let entityVerb = NSEntityDescription.entity(forEntityName: "Verb", in: managedContext)!
            let entityVerbProgress = NSEntityDescription.entity(forEntityName: "VerbProgress", in: managedContext)!
            
            let verb = Verb(entity: entityVerb, insertInto: managedContext)
            verb.progress = VerbProgress(entity: entityVerbProgress, insertInto: managedContext)
            
            let verbDict = dict as! [String: Any]
            
            verb.infinitive = verbDict["infinitive"] as? String
            verb.pastSimple = verbDict["pastSimple"] as? String
            verb.pastParticiple = verbDict["pastParticiple"] as? String
            
            verb.infinitiveTranscription = verbDict["infinitiveTranscription"] as? String
            verb.pastSimpleTranscription = verbDict["pastSimpleTranscription"] as? String
            verb.pastParticipleTranscription = verbDict["pastParticipleTranscription"] as? String
            
            verb.translation = verbDict["translation"] as? String
            
            let variants: [String]? = verbDict["variants"] as? [String]
            
            verb.variants = variants as NSObject?
            
            verb.isLearn = true
            
            verb.progress?.rightAnswersToday = 0
            verb.progress?.wrongAnswersToday = 0
            verb.progress?.rightAnswersForAllTime = 0
            verb.progress?.wrongAnswersForAllTime = 0
        }
        
        try! managedContext.save()
        
    }
}


// MARK: - StoreServiceSettings

protocol StoreServiceSettingsProtocol {
    func savedVibration() -> Bool
    func saveVibration(with value: Bool)
}

class StoreSettingsService: StoreServiceSettingsProtocol {
    
    private let kSavedVibrationState = "CurbYourVerb.savedVibrationState"
        
    func savedVibration() -> Bool {
        if UserDefaults.standard.object(forKey: kSavedVibrationState) != nil {
            return UserDefaults.standard.bool(forKey: kSavedVibrationState)
        }
        return true
    }
    
    func saveVibration(with value: Bool) {
        UserDefaults.standard.set(value, forKey: kSavedVibrationState)
        UserDefaults.standard.synchronize()
    }
}
