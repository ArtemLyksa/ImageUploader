//
//  GenericError.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation

enum GenericError: Error {
    
    case unknown
    case cannotParseData
    case wrongUrl(String)
    case imageAlreadyUploaded
    case generic(Error)
    
    var localizedDescription: String {
        switch self {
        case .unknown:
            return "Unknown error. Please, contact support".localized
        case .cannotParseData:
            return "Cannot parse response. Please, contact support".localized
        case .wrongUrl(let incomingURL):
            return "Cannot create URL. Incoming URL: ".localized + incomingURL
        case .imageAlreadyUploaded:
            return "This image has been already uploaded to the server".localized
        case .generic(let error):
            let nserror = error as NSError
            return nserror.localizedDescription
        }
    }
    
}
