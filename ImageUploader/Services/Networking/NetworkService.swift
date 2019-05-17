//
//  NetworkService.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation

class NetworkService {
    
    private let realizer: RequestRealizer
    private let token: String
    
    init(realizer: RequestRealizer, token: String) {
        self.realizer = realizer
        self.token = token
    }
    
    convenience init() {
        self.init(realizer: RequestRealizer(), token: "Bearer 143ffc7c7280ec9f0c6ce1509775b1d84efc516a")
        
    }
    
    func upload(data: UploadImageRequestData, _ completion: @escaping (RequestResult<UploadImageResponse>) -> Void) {
        
        let reqdata = try! JSONEncoder().encode(data)
        let request = Request(url: ImgGurURL.upload, method: .post, body: reqdata, token: token)
        return realizer.realize(request: request, { (result: RequestResult<UploadImageResponse>) in
            completion(result)
        })
        
    }
}
