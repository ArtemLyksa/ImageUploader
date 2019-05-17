//
//  ModelConstructor.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import CoreData

struct Constructor {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func create<T: NSManagedObject>() -> T {
        let name = "\(T.self)"
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)
        return T(entity: entity!, insertInto: context)
    }
}
