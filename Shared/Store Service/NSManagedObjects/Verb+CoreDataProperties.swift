//
//  Verb+CoreDataProperties.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 02.08.2020.
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
    @NSManaged public var infinitiveTranscription: String?
    @NSManaged public var isLearn: Bool
    @NSManaged public var pastParticiple: String?
    @NSManaged public var pastParticipleTranscription: String?
    @NSManaged public var pastSimple: String?
    @NSManaged public var pastSimpleTranscription: String?
    @NSManaged public var section: String?
    @NSManaged public var translation: String?
    @NSManaged public var variants: NSObject?
    @NSManaged public var infinitiveIPA: String?
    @NSManaged public var pastSimpleIPA: String?
    @NSManaged public var pastParticipleIPA: String?
    @NSManaged public var progress: VerbProgress?

}
