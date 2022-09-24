
import Foundation
import CoreData


extension StoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoryEntity> {
        return NSFetchRequest<StoryEntity>(entityName: "StoryEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var subject: String?
    @NSManaged public var story_description: String?
    @NSManaged public var dateTime: Date?
    @NSManaged public var assignee: EmployeeEntity?

}

extension StoryEntity : Identifiable {

}
