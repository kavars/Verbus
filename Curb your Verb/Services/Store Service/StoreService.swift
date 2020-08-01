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
        
    func updateContext() // ?
    
    func verbsFetch(of type: FetchType) -> [Verb]?
    
    func resetStats()
    
    func newDayUpdate()
}

// MARK: - StoreServiceVerbsFetchedResultsControllerProtocol

protocol StoreServiceVerbsFetchedResultsControllerProtocol: class {
    var fetchedResultsController: NSFetchedResultsController<Verb> { get }
    
    func fetchResultsController()
    func saveContext()

}

class StoreServiceCoreData: StoreServiceVerbsProtocol {
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    lazy var sampleLoader: SampleLoaderProtocol = {
        return SampleLoader()
    }()
    
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
    
    // ?
    func updateContext() {
        let container = NSPersistentContainer(name: self.modelName)
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        self.storeContainer = container
    }
    //
    
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
    
    func verbsFetch(of type: FetchType) -> [Verb]? {
        
        var verbs: [Verb] = []
        
        // Load sample verbs
        sampleLoader.insertSampleData(to: self.managedContext)
        
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
    
    func resetStats() {
        let batchUpdateVerb = NSBatchUpdateRequest(entityName: "Verb")
        batchUpdateVerb.propertiesToUpdate = [
            #keyPath(Verb.isLearn): true
        ]
        
        batchUpdateVerb.affectedStores = managedContext.persistentStoreCoordinator?.persistentStores
        batchUpdateVerb.resultType = .updatedObjectsCountResultType
        
        do {
            _ = try managedContext.execute(batchUpdateVerb) as! NSBatchUpdateResult
        } catch let error as NSError {
            print("Could not update \(error), \(error.userInfo)")
        }
        
        let batchUpdateVerbProgress = NSBatchUpdateRequest(entityName: "VerbProgress")
        batchUpdateVerbProgress.propertiesToUpdate = [
            #keyPath(VerbProgress.rightAnswersToday): 0,
            #keyPath(VerbProgress.rightAnswersForAllTime): 0,
            #keyPath(VerbProgress.wrongAnswersToday): 0,
            #keyPath(VerbProgress.wrongAnswersForAllTime): 0
        ]
        
        batchUpdateVerbProgress.affectedStores = managedContext.persistentStoreCoordinator?.persistentStores
        batchUpdateVerbProgress.resultType = .updatedObjectsCountResultType
        
        do {
            _ = try managedContext.execute(batchUpdateVerbProgress) as! NSBatchUpdateResult
        } catch let error as NSError {
            print("Could not update \(error), \(error.userInfo)")
        }
    }
    
    func newDayUpdate() {
        let batchUpdateVerbProgress = NSBatchUpdateRequest(entityName: "VerbProgress")
        batchUpdateVerbProgress.propertiesToUpdate = [
            #keyPath(VerbProgress.rightAnswersToday): 0,
            #keyPath(VerbProgress.wrongAnswersToday): 0
        ]
        
        batchUpdateVerbProgress.affectedStores = managedContext.persistentStoreCoordinator?.persistentStores
        batchUpdateVerbProgress.resultType = .updatedObjectsCountResultType
        
        do {
            _ = try managedContext.execute(batchUpdateVerbProgress) as! NSBatchUpdateResult
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

    func fetchResultsController() {
        do {
          try fetchedResultsController.performFetch()
        } catch let error as NSError {
          print("Fetching error: \(error), \(error.userInfo)")
        }
    }
}


// MARK: - StoreServiceSettings

protocol StoreServiceSettingsProtocol {
    func savedVibration() -> Bool
    func saveVibration(with value: Bool)
    
    func savedDay() -> Date
    func saveDay(with value: Date)
}

class StoreSettingsService: StoreServiceSettingsProtocol {
    
    private let kSavedVibrationState = "CurbYourVerb.savedVibrationState"
    private let kSavedDay = "CurbYourVerb.savedDay"
    
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
}
