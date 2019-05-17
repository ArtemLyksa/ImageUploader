//
//  DisplayedAsset.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import Photos

class DisplayedAsset {
    let asset: PHAsset
    var image: UIImage?
    var id: String {
        return asset.localIdentifier
    }
    
    init(asset: PHAsset) {
        self.asset = asset
    }
}
