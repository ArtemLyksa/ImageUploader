//
//  AssetLink+dataBase.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation

extension AssetLink {
    
    init?(dbLink: DBLink) {
        guard let value = dbLink.value, let id = dbLink.id else {
            return nil
        }
        self.init(value: value, id: id)
    }
}
