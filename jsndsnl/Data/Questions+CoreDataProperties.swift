//
//  Questions+CoreDataProperties.swift
//  jsndsnl
//
//  Created by Кирилл Кучмар on 03.04.2021.
//
//

import Foundation
import CoreData


extension Questions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Questions> {
        return NSFetchRequest<Questions>(entityName: "Questions")
    }

    @NSManaged public var question: String?
    @NSManaged public var answer: Int64
    @NSManaged public var link: UUID?
    @NSManaged public var kak: Data?

}

extension Questions : Identifiable {

}
