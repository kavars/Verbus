//
//  SampleLoader.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 01.08.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation
import CoreData


protocol DataLoaderProtocol: class {
    func insertSampleData(to managedContext: NSManagedObjectContext)
    func seedCoreDataContainerIfFirstLaunch(to modelName: String)
}

class DataLoader: DataLoaderProtocol {

    func insertSampleData(to managedContext: NSManagedObjectContext) {
        
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
            
            verb.infinitiveIPA = verbDict["infinitiveIPA"] as? String
            verb.pastSimpleIPA = verbDict["pastSimpleIPA"] as? String
            verb.pastParticipleIPA = verbDict["pastParticipleIPA"] as? String
            
            verb.translation = verbDict["translation"] as? String
            
            verb.section = verbDict["section"] as? String
            
            let variants: [String]? = verbDict["variants"] as? [String]
            
            verb.variants = variants as NSObject?
            
            if verb.section == "Top 50" {
                verb.isLearn = true
            } else {
                verb.isLearn = false
            }
            
            verb.progress?.rightAnswersToday = 0
            verb.progress?.wrongAnswersToday = 0
            verb.progress?.rightAnswersForAllTime = 0
            verb.progress?.wrongAnswersForAllTime = 0
        }
        
        try! managedContext.save()
        
    }
    
    func seedCoreDataContainerIfFirstLaunch(to modelName: String) {

      let previouslyLaunched = UserDefaults.standard.bool(forKey: "previouslyLaunched")
      if !previouslyLaunched {

        let directory = NSPersistentContainer.defaultDirectoryURL()
        
        let extensionArray = ["sqlite", "sqlite-shm", "sqlite-wal"]

        for fileExtension in extensionArray {
            copyingFile(of: modelName, fileExtension: fileExtension, in: directory)
        }

        UserDefaults.standard.set(true, forKey: "previouslyLaunched")
        print("Seeded Core Data")
      }
    }
    
    private func copyingFile(of modelName: String, fileExtension: String, in directory: URL) {
        let seededURL = Bundle.main.url(forResource: modelName, withExtension: fileExtension)!
        let url = directory.appendingPathComponent(modelName + "." + fileExtension)
        _ = try? FileManager.default.removeItem(at: url)
        
        do {
            try FileManager.default.copyItem(at: seededURL, to: url)
        } catch let error as NSError {
            fatalError("Error: \(error.localizedDescription)")
        }
    }
}
