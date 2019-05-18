//
//  DisplayedLink.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/18/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation

struct DisplayedLink {
    let value: String
    
    init(with assetLink: AssetLink) {
        self.value = assetLink.value
    }
}
