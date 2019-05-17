//
//  InAppURL.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation

protocol InAppURL {
    var value: URL? { get }
}

enum ImgGurURL: String, InAppURL {
    
    case upload = "https://api.imgur.com/3/upload"
    
    var value: URL? {
        return URL(string: rawValue)
    }
}
