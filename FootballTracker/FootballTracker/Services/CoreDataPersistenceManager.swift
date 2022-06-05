//
//  CoreDataPersistenceManager.swift
//  FootballTracker
//
//  Created by Philip Boyko on 1.06.22.
//

import Foundation
import CoreData

protocol CoreDataPersistenceManagerProviding {
    var persistentContainer: NSPersistentContainer { get }
    func savePersistentContainer()
}

final class CoreDataPersistenceManagerProvider: CoreDataPersistenceManagerProviding {

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FootballTracker")
        container.loadPersistentStores { (description, error) in
            guard error == nil else {
                fatalError("Unresolved error \(String(describing: error))")
            }
        }
        return container
    }()
    
    func savePersistentContainer() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Faild to save in CoreData, \(error)")
            }
        }
    }

}
