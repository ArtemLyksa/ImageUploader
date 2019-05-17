//
//  ImageUploadingPresenter.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

class ImageUploadingPresenter {
    
    var uploadingAssetChanged: (IndexPath) -> (Void) = { _ in }
    var errorOccurred: (GenericError) -> (Void) = { _ in }
    
    private var uploadingImages: [DisplayedAsset] = []
    private let networkService: NetworkService
    private let queue = OperationQueue()
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .background
    }
    
    func uploadAsset(_ asset: DisplayedAsset, indexPath: IndexPath) {
        
        guard asset.state != .uploaded, let requestData = UploadImageRequestData(asset: asset) else {
            return
        }
        
        asset.state = .uploading
        uploadingImages.append(asset)
        uploadingAssetChanged(indexPath)
        
        let operation = ImageUploadingOperation(requestData: requestData, networkService: networkService)
        
        operation.completionBlock = {
            OperationQueue.main.addOperation { [weak self] in
                asset.state = .uploaded
                self?.uploadingAssetChanged(indexPath)
                self?.handle(operation.result!)
            }
        }
        
        queue.addOperation(operation)
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
