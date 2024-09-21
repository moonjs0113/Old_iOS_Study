//
//  Country+CoreDataProperties.swift
//  StudyUI2
//
//  Created by Moon Jongseek on 2022/04/01.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var fullName: String?
    @NSManaged public var shortName: String?
    @NSManaged public var candy: Set<Candy>?

    public var wrappedShortName: String {
        self.shortName ?? "Unknown Country"
    }

    public var wrappedFullName: String {
        self.fullName ?? "Unknown Country"
    }
    
    public var candyArray: [Candy] {
        let set = self.candy ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for candy
extension Country {

    @objc(addCandyObject:)
    @NSManaged public func addToCandy(_ value: Candy)

    @objc(removeCandyObject:)
    @NSManaged public func removeFromCandy(_ value: Candy)

    @objc(addCandy:)
    @NSManaged public func addToCandy(_ values: NSSet)

    @objc(removeCandy:)
    @NSManaged public func removeFromCandy(_ values: NSSet)

}

extension Country : Identifiable {

}
