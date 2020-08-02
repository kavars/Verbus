//
//  VerbProgress+CoreDataProperties.swift
//  Curb your Verb
//
//  Created by Kirill Varshamov on 02.08.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//
//

import Foundation
import CoreData


extension VerbProgress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VerbProgress> {
        return NSFetchRequest<VerbProgress>(entityName: "VerbProgress")
    }

    @NSManaged public var rightAnswersForAllTime: Int32
    @NSManaged public var rightAnswersToday: Int32
    @NSManaged public var wrongAnswersForAllTime: Int32
    @NSManaged public var wrongAnswersToday: Int32
    @NSManaged public var verb: Verb?

}
