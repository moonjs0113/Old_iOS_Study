//
//  Singer+CoreDataProperties.swift
//  StudyUI2
//
//  Created by Moon Jongseek on 2022/04/01.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?

    var wrappedFirstName: String {
        self.firstName ?? "Unknown"
    }
    
    var wrappedLastName: String {
        self.lastName ?? "Unknown"
    }
}

extension Singer : Identifiable {

}
