//
//  CoreDataChat+CoreDataProperties.swift
//  Messenger_TestApp
//
//  Created by Андрей Шамин on 4/6/21.
//
//

import Foundation
import CoreData


extension CoreDataChat {

    @nonobjc public class func fetch() -> NSFetchRequest<CoreDataChat> {
        return NSFetchRequest<CoreDataChat>(entityName: "CoreDataChat")
    }

    @NSManaged public var id: String
    @NSManaged public var relationship: NSSet?

}

// MARK: Generated accessors for relationship
extension CoreDataChat {

    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: CoreDataMessage)

    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: CoreDataMessage)

    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ values: NSSet)

    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ values: NSSet)

}

extension CoreDataChat : Identifiable {

}
