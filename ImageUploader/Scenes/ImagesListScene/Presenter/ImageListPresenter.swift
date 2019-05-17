//
//  ImageListPresenter.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import Photos

struct ImagesListPresenter {
    
    private let photoService: PhotoService
    
    lazy var assets: [PHAsset] = {
        return photoService.fetchAllAssets()
    }()
    
    init(photoService: PhotoService) {
        self.photoService = photoService
    }
    
}
