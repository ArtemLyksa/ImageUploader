//
//  CoreDataManager.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    private lazy var constructor: Constructor = {
        return Constructor(context: context)
    }()
    
    private lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModels")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension CoreDataManager: DataBaseManager {
    
    func save(link: AssetLink) {
        
        let dbLink = DBLink.create(constructor: constructor, assetLink: link)
        context.insert(dbLink)
        try? context.save()
    }
    
    func fetchLinks() -> [AssetLink] {
        
        let request: NSFetchRequest<DBLink> = DBLink.fetchRequest()
        request.returnsObjectsAsFaults = false
        
        do {
            return try context.fetch(request).compactMap({ dbLink in
                return AssetLink(dbLink: dbLink)
            })
        } catch {
            print(error)
            return []
        }
    }
    
    func linkExists(id: String) -> Bool {
        let request: NSFetchRequest<DBLink> = DBLink.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        request.returnsObjectsAsFaults = false
        
        return (try? context.fetch(request))?.isEmpty == false
    }
    
    func synchronize() {
        try? context.save()
    }
}
