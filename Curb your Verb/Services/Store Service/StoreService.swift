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
        
    func refreshContext()
    
    func verbsFetch(of type: FetchType) -> [Verb]?
    
    func resetStats()
    func newDayUpdate()
}

// MARK: - StoreServiceVerbsFetchedResultsControllerProtocol
protocol StoreServiceVerbsFetchedResultsControllerProtocol: class {
    var fetchedResultsController: NSFetchedResultsController<Verb> { get }
    
    func fetchResultsController(of search: String)
    func saveContext()

    func deleteCache()
    
    func refreshContext()
}

class StoreServiceCoreData: StoreServiceVerbsProtocol {
    
    // MARK: - Core Data Stack
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    lazy var dataLoader: DataLoaderProtocol = {
        return DataLoader()
    }()
    
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
//        self.dataLoader.seedCoreDataContainerIfFirstLaunch(to: self.modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        return container
    }()
    
    func refreshContext() {
        managedContext.refreshAllObjects()
    }
    
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
    
    // MARK: - Fetch
    
    func verbsFetch(of type: FetchType) -> [Verb]? {
        
        var verbs: [Verb] = []
        
        // Load sample verbs
        dataLoader.insertSampleData(to: self.managedContext)
        
        let fetch: NSFetchRequest<Verb> = Verb.fetchRequest()
        var predicate: NSPredicate?
        var sortDescriptor: NSSortDescriptor?
        
        switch type {
        case .all:
            predicate = nil
            sortDescriptor = NSSortDescriptor(key: #keyPath(Verb.infinitive), ascending: true)
        case .onLearning:
            predicate = NSPredicate(format: "%K == %@", argumentArray: [#keyPath(Verb.isLearn), true])
            sortDescriptor = nil
        case.search(let infinitive):
            if !infinitive.isEmpty {
                predicate = NSPredicate(format: "%K CONTAINS[c] %@", argumentArray: [#keyPath(Verb.infinitive), infinitive])
            }
            sortDescriptor = NSSortDescriptor(key: #keyPath(Verb.infinitive), ascending: true)
        }
        
        fetch.predicate = predicate
        if let sr = sortDescriptor {
            fetch.sortDescriptors = [sr]
        }
        
        do {
            verbs = try self.managedContext.fetch(fetch)
            
            return verbs
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    // MARK: - Batch Update
    func resetStats() {
        
        let entityToUpdate = [
            "Verb": [
                #keyPath(Verb.isLearn): true
            ],
            "VerbProgress": [
                #keyPath(VerbProgress.rightAnswersToday): 0,
                #keyPath(VerbProgress.rightAnswersForAllTime): 0,
                #keyPath(VerbProgress.wrongAnswersToday): 0,
                #keyPath(VerbProgress.wrongAnswersForAllTime): 0
            ]
        ]
        
        for entity in entityToUpdate {
            batchUpdate(entityName: entity.key, with: entity.value)
        }
    }
    
    func newDayUpdate() {
        let propToUpdate = [
            #keyPath(VerbProgress.rightAnswersToday): 0,
            #keyPath(VerbProgress.wrongAnswersToday): 0
        ]
        
        batchUpdate(entityName: "VerbProgress", with: propToUpdate)
    }
    
    private func batchUpdate(entityName: String, with propertiesToUpdate: [AnyHashable : Any]?) {
        let batchUpdate = NSBatchUpdateRequest(entityName: entityName)
        batchUpdate.propertiesToUpdate = propertiesToUpdate
        
        batchUpdate.affectedStores = managedContext.persistentStoreCoordinator?.persistentStores
        batchUpdate.resultType = .updatedObjectsCountResultType
        
        do {
            _ = try managedContext.execute(batchUpdate) as! NSBatchUpdateResult
        } catch let error as NSError {
            print("Could not update \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - NSFetchedResultsController

    lazy var fetchedResultsController: NSFetchedResultsController<Verb> = {
        let fetchRequest: NSFetchRequest<Verb> = Verb.fetchRequest()
        
        
        
        let topSort = NSSortDescriptor(key: #keyPath(Verb.section), ascending: true)
        let nameSort = NSSortDescriptor(key: #keyPath(Verb.infinitive), ascending: true)
        fetchRequest.sortDescriptors = [topSort, nameSort]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedContext, sectionNameKeyPath: #keyPath(Verb.section), cacheName: "verbsCache")
        
        return fetchedResultsController
    }()
}

extension StoreServiceCoreData: StoreServiceVerbsFetchedResultsControllerProtocol {

    func fetchResultsController(of search: String) {
        
        if !search.isEmpty {
            fetchedResultsController.fetchRequest.predicate = NSPredicate(format: "%K CONTAINS[c] %@", argumentArray: [#keyPath(Verb.infinitive), search])
            deleteCache()
        }
        
        do {
          try fetchedResultsController.performFetch()
        } catch let error as NSError {
          print("Fetching error: \(error), \(error.userInfo)")
        }
    }
    
    func deleteCache() {
        NSFetchedResultsController<Verb>.deleteCache(withName: "verbsCache")
    }
}


// MARK: - StoreServiceSettings

protocol StoreServiceSettingsProtocol {
    func savedVibration() -> Bool
    func saveVibration(with value: Bool)
    
    func savedDay() -> Date
    func saveDay(with value: Date)
    
    func savedTutorial() -> Bool
    func saveTutorial(with value: Bool)
}

class StoreSettingsService: StoreServiceSettingsProtocol {
    
    private let kSavedVibrationState = "CurbYourVerb.savedVibrationState"
    private let kSavedDay = "CurbYourVerb.savedDay"
    private let kSavedTutorial = "CurbYourVerb.savedTutorial"
    
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
    
    func savedDay() -> Date {
        if UserDefaults.standard.object(forKey: kSavedDay) != nil {
            return UserDefaults.standard.object(forKey: kSavedDay) as! Date
        }
        return Date()
    }
    
    func saveDay(with value: Date) {
        UserDefaults.standard.set(value, forKey: kSavedDay)
        UserDefaults.standard.synchronize()
    }
    
    func savedTutorial() -> Bool {
        if UserDefaults.standard.object(forKey: kSavedTutorial) != nil {
            return UserDefaults.standard.bool(forKey: kSavedTutorial)
        }
        return true
    }
    
    func saveTutorial(with value: Bool) {
        UserDefaults.standard.set(value, forKey: kSavedTutorial)
        UserDefaults.standard.synchronize()
    }
}

// MARK: - DailyStrikeProtocol

protocol DailyStrikeProtocol: class {
    func savedDailyStrike() -> Int
    func saveDailyStrike(with value: Int)
}

class DailyStrike: DailyStrikeProtocol {
    
    private let kSavedDay = "CurbYourVerb.DailyStrike"
    
    func savedDailyStrike() -> Int {
        if UserDefaults.standard.object(forKey: kSavedDay) != nil {
            return UserDefaults.standard.integer(forKey: kSavedDay)
        }
        return 0
    }
    
    func saveDailyStrike(with value: Int) {
        
        if value < 0 {
            UserDefaults.standard.set(0, forKey: kSavedDay)
        } else if value > 6 {
            UserDefaults.standard.set(6, forKey: kSavedDay)
        } else {
            UserDefaults.standard.set(value, forKey: kSavedDay)
        }
        
        UserDefaults.standard.synchronize()
    }
    
    
}
