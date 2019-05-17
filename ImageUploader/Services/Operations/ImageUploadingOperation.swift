//
//  ImageUploadingOperation.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation

class ImageUploadingOperation: AsyncOperation {
    
    var result: RequestResult<UploadImageResponse>?
    
    private let requestData: UploadImageRequestData
    private let networkService: NetworkService
    
    override var isConcurrent: Bool {
        return false
    }
    
    init(requestData: UploadImageRequestData, networkService: NetworkService) {
        self.requestData = requestData
        self.networkService = networkService
        super.init()
    }
    
    override func execute() {
        networkService.upload(data: requestData) { result in
            self.result = result
            self.isExecuting = false
            self.isFinished = true
        }
    }
}
