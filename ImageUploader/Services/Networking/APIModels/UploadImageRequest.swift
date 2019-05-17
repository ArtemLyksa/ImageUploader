//
//  UploadImageRequest.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

struct UploadImageRequestData: Encodable {
    
    let image: String
    
    init?(asset: DisplayedAsset) {
        guard let imageString = asset.image?.pngData()?.base64EncodedString() else {
            return nil
        }
        self.image = imageString
    }
}
