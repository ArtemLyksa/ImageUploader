//
//  DBLink+constructor.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation

extension DBLink {
    
    static func create(constructor: Constructor, assetLink: AssetLink) -> DBLink {
        let dbLink: DBLink = constructor.create()
        dbLink.value = assetLink.value
        dbLink.id = assetLink.id
        return dbLink
    }
    
}
