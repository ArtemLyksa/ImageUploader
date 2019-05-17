//
//  ImageUploadingPresenter.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

class ImageUploadingPresenter {
    
    private let networkService: NetworkService
    private var uploadingImages: [DisplayedAsset] = []
    
    var uploadingAssetChanged: (IndexPath) -> (Void) = { _ in }
    var errorOccurred: (GenericError) -> (Void) = { _ in }
    
    //TODO: Add a queue
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func uploadAsset(_ asset: DisplayedAsset, indexPath: IndexPath) {
        
        guard asset.state != .uploaded, let requestData = UploadImageRequestData(asset: asset) else {
            return
        }
        
        asset.state = .uploading
        uploadingImages.append(asset)
        uploadingAssetChanged(indexPath)
        
        networkService.upload(data: requestData) { [weak self] response in
            DispatchQueue.main.async {
                asset.state = .uploaded
                self?.uploadingAssetChanged(indexPath)
                self?.handle(response)
            }
        }
    }
    
    private func handle(_ response: RequestResult<UploadImageResponse>) {
        
        if let error = response.error {
            errorOccurred(error)
            return
        }
        
        //TODO: Save link
        if let value = response.value {
            print(value.link)
        }
    }
}
