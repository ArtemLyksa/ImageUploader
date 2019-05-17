//
//  ImageUploadingPresenter.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

struct ImageUploadingPresenter {
    
    private let networkService: NetworkService
    private var uploadingImages: Set<UploadingAsset> = []
    //TODO: Add a queue
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    mutating func uploadAsset(_ asset: DisplayedAsset) {
        guard let image = asset.image, let imageData = image.pngData() else {
            return
        }
        
        let asset = UploadingAsset(image: image, state: .uploading, id: asset.id)
        uploadingImages.insert(asset)
        
        //TODO: Handle result
        networkService.upload(data: imageData)
    }
}
