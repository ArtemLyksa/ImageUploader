//
//  UploadImageResponse.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation

class UploadImageResponse: Decodable {
    
    private let data: UploadImageResponseData
    
    lazy var link: String = {
        return data.link
    }()
    
}

private struct UploadImageResponseData: Decodable {
    let link: String
}
