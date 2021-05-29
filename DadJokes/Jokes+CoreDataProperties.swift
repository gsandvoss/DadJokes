//
//  Jokes+CoreDataProperties.swift
//  DadJokes
//
//  Created by glenn sandvoss on 5/27/21.
//
//

import Foundation
import CoreData


extension Jokes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Jokes> {
        return NSFetchRequest<Jokes>(entityName: "Jokes")
    }

    @NSManaged public var setup: String
    @NSManaged public var punchline: String
    @NSManaged public var rating: String

}

extension Jokes : Identifiable {

}
