//
//  DataController.swift
//  StudyUI2
//
//  Created by Moon Jongseek on 2022/04/01.
//

import CoreData

class DataController: ObservableObject {
    var container: NSPersistentContainer
    
    init(containerName: String) {
        self.container = NSPersistentContainer(name: containerName)
        self.container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data Failed to load: \(error.localizedDescription)")
                return
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
