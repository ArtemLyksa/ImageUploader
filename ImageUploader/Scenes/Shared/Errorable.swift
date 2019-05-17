//
//  Errorable.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

protocol Errorable {
    
    var handleError: (Error) -> Void { get }
}

extension Errorable where Self: UIViewController {
    
    var handleError: (Error) -> Void {
        return { [weak self] error in
            self?.showError(error: error)
        }
    }
}
