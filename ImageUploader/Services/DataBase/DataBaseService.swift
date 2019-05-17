//
//  DataBaseService.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import CoreData

protocol DataBaseManager {
    
    func save(link: AssetLink)
    func fetchLinks() -> [AssetLink]
    func linkExists(id: String) -> Bool
}

class DataBaseService {
    
    let manager: DataBaseManager
    
    init(manager: DataBaseManager) {
        self.manager = manager
    }
    func save(link: AssetLink) {
        manager.save(link: link)
    }
    
    func fetchLinks() -> [AssetLink] {
        return manager.fetchLinks()
    }
    
    func linkExists(id: String) -> Bool {
        return manager.linkExists(id: id)
    }
}
