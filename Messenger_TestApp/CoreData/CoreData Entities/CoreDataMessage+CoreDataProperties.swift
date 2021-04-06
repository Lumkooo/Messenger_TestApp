//
//  CoreDataMessage+CoreDataProperties.swift
//  Messenger_TestApp
//
//  Created by Андрей Шамин on 4/6/21.
//
//

import Foundation
import CoreData


extension CoreDataMessage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataMessage> {
        return NSFetchRequest<CoreDataMessage>(entityName: "CoreDataMessage")
    }

    @NSManaged public var text: String
    @NSManaged public var time: String
    @NSManaged public var isOutgoing: Bool
    @NSManaged public var relationship: CoreDataChat?

}

extension CoreDataMessage : Identifiable {

}
