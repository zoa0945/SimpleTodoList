//
//  PersistenceController.swift
//  SimpleList
//
//  Created by Nam Hoon Jeong on 4/28/25.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "TodoModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Core Data error \(error), \(error.userInfo)")
            }
        }
    }
}
