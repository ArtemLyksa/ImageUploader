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
    
    lazy var assets: [DisplayedAsset] = {
        return photoService.fetchAllAssets().map({ DisplayedAsset(asset: $0) })
    }()
    
    init(photoService: PhotoService) {
        self.photoService = photoService
    }
    
    mutating func asset(for indexPath: IndexPath, size: CGSize, result: @escaping (DisplayedAsset) -> Void) {
        let displayedAsset = assets[indexPath.row]
        
        if displayedAsset.image != nil {
            result(displayedAsset)
            return
        }
        
        photoService.getImage(from: displayedAsset.asset, size: size) { (image) in
            displayedAsset.image = image
            result(displayedAsset)
        }
        
    }
}
