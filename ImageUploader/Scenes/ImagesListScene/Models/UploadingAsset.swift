//
//  UploadingAsset.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

enum UploadingState {
    case notUploaded
    case uploading
    case uploaded
}

class UploadingAsset {
    let image: UIImage
    var state: UploadingState
    var id: String
    
    init(image: UIImage, state: UploadingState = .notUploaded, id: String) {
        self.image = image
        self.state = state
        self.id = id
    }
}

extension UploadingAsset: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: UploadingAsset, rhs: UploadingAsset) -> Bool {
        return lhs.id == rhs.id
    }
}
