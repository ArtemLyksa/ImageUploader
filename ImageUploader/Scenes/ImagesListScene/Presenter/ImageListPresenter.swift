//
//  ImageListPresenter.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import Photos

class ImagesListPresenter {
    
    var assetsChangedHandler: () -> (Void) = { }
    private(set) var assets: [DisplayedAsset] = [] {
        didSet {
            assetsChangedHandler()
        }
    }
    private let photoService: PhotoService
    
    init(photoService: PhotoService) {
        self.photoService = photoService
        getAssets()
    }
    
    func asset(for indexPath: IndexPath, size: CGSize, result: @escaping (DisplayedAsset) -> Void) {
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
    
    private func getAssets() {
        photoService.fetchAllAssets { [weak self] assets in
            guard let self = self else { return }
            self.assets = assets.map({ DisplayedAsset(asset: $0) })
        }
    }
}
