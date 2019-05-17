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
    
    private let dbService = DataBaseService(manager: CoreDataManager())
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .background
    }
    
    func uploadAsset(_ asset: DisplayedAsset, indexPath: IndexPath) {
        
        if asset.state == .uploaded {
            return
        }
        
        if dbService.linkExists(id: asset.id) {
            //TODO: Show alert
            asset.state = .uploaded
            return
        }
        
        guard let requestData = UploadImageRequestData(asset: asset) else {
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
                
                if let error = operation.result?.error {
                    self?.errorOccurred(error)
                    return
                }
                
                if let value = operation.result?.value {
                    self?.dbService.save(link: AssetLink(value: value.link, id: asset.id))
                }
            }
        }
        
        queue.addOperation(operation)
    }
}
