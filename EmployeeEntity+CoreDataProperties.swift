//
//  EmployeeEntity+CoreDataProperties.swift
//  StoryApplication
//
//  Created by Eduard Spahija on 9/21/22.
//
//

import Foundation
import CoreData


extension EmployeeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeeEntity> {
        return NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: Int32
    @NSManaged public var last_name: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var position: String?
    @NSManaged public var stories: NSSet?

}

// MARK: Generated accessors for stories
extension EmployeeEntity {

    @objc(addStoriesObject:)
    @NSManaged public func addToStories(_ value: StoryEntity)

    @objc(removeStoriesObject:)
    @NSManaged public func removeFromStories(_ value: StoryEntity)

    @objc(addStories:)
    @NSManaged public func addToStories(_ values: NSSet)

    @objc(removeStories:)
    @NSManaged public func removeFromStories(_ values: NSSet)

}

extension EmployeeEntity : Identifiable {

}
