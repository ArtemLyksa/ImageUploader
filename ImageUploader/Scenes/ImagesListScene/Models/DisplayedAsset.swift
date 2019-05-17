//
//  DisplayedAsset.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import Photos

enum UploadingState {
    case notUploaded
    case uploading
    case uploaded
}

protocol Uploadable: class {
    var state: UploadingState { get }
    var image: UIImage? { get }
}

class DisplayedAsset: Uploadable {
    let asset: PHAsset
    var image: UIImage?
    var state: UploadingState = .notUploaded
    
    var id: String {
        return asset.localIdentifier
    }
    
    init(asset: PHAsset) {
        self.asset = asset
    }
}
