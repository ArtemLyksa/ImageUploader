//
//  PhotoService.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation
import Photos

struct PhotoService {
    
    private let imageManager = PHCachingImageManager()
    private let qos: DispatchQoS.QoSClass
    
    init(qos: DispatchQoS.QoSClass = .background) {
        self.qos = qos
    }
    
    func fetchAllAssets(result: @escaping ([PHAsset]) -> Void) {
        
        PHPhotoLibrary.requestAuthorization { status in
            var assets: [PHAsset] = []
            
            guard status == .authorized else {
                result(assets)
                return
            }
            
            let allPhotosOptions = PHFetchOptions()
            allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
            
            
            PHAsset.fetchAssets(with: allPhotosOptions).enumerateObjects { (asset, _, _) in
                assets.append(asset)
            }
            result(assets)
        }
    }
    
    func getImage(from asset: PHAsset,
                  size: CGSize,
                  contentMode: PHImageContentMode = .aspectFill,
                  result: @escaping (UIImage?) -> Void) {
        
        DispatchQueue.global(qos: qos).async {
            self.imageManager.requestImage(for: asset, targetSize: size, contentMode: contentMode, options: nil) { image, _ in
                DispatchQueue.main.async {
                    result(image)
                }
            }
        }
    }
}
