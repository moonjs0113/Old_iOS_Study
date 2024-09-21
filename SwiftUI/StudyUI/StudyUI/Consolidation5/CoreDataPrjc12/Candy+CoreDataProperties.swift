//
//  Candy+CoreDataProperties.swift
//  StudyUI2
//
//  Created by Moon Jongseek on 2022/04/01.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?

    public var wrappedName: String {
        print(self.name ?? "Unknown Candy")
        return self.name ?? "Unknown Candy"
    }
}

extension Candy : Identifiable {

}
