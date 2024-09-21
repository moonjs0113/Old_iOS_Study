//
//  Movie+CoreDataProperties.swift
//  StudyUI2
//
//  Created by Moon Jongseek on 2022/04/01.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String
    @NSManaged public var year: Int16
    
    private var wrappedTitle: String {
        self.title ?? "Unkwon Title"
    }
}

extension Movie : Identifiable {

}
