//
//  Request.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Request {
    
    let url: InAppURL
    let endpoint: String
    let method: HTTPMethod
    let body: Data?
    let token: String?
    
    init(url: InAppURL,
         endpoint: String = "",
         method: HTTPMethod = .get,
         body: Data? = nil,
         token: String? = nil) {
        
        self.url = url
        self.endpoint = endpoint
        self.method = method
        self.body = body
        self.token = token
    }
    
    func asURLRequest() -> URLRequest {
        
        let fullUrl = url.value!.appendingPathComponent(endpoint)
        
        var request = URLRequest(url: fullUrl)
        
        if let token = token {
            request.setValue(token, forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        if let body = body {
            request.httpBody = body
        }
        
        request.httpMethod = method.rawValue
        
        return request
    }
}
