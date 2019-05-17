//
//  RequestRealizer.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation

struct RequestResult<T> {
    let error: GenericError?
    let value: T?
    
    init(value: T?, error: Error?) {
        self.value = value
        
        if let error = error {
            self.error = GenericError.generic(error)
        } else {
            self.error = nil
        }
    }
}

struct RequestRealizer {
    
    func realize<T: Decodable>(request: Request, _ completion: @escaping (RequestResult<T>) -> Void) {
        let task = URLSession.shared.dataTask(with: request.asURLRequest()) { data, response, error in
            let result = RequestResult<T>(value: data?.decode(), error: error)
            completion(result)
        }
        
        task.resume()
    }
}
