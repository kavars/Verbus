//
//  Verb+CoreDataProperties.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 14.07.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//
//

import Foundation
import CoreData


extension Verb {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Verb> {
        return NSFetchRequest<Verb>(entityName: "Verb")
    }

    @NSManaged public var infinitive: String?
    @NSManaged public var pastSimple: String?
    @NSManaged public var pastParticiple: String?
    @NSManaged public var variants: NSObject?
    @NSManaged public var infinitiveTranscription: String?
    @NSManaged public var pastSimpleTranscription: String?
    @NSManaged public var pastParticipleTranscription: String?
    @NSManaged public var translation: String?
    @NSManaged public var isLearn: Bool
    @NSManaged public var progress: VerbProgress?

}
