//
//  UIViewController+erroArlert.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showError(error: Error) {
        let message: String = {
            if let genericError = error as? GenericError {
                return genericError.localizedDescription
            }
            return error.localizedDescription
        }()
        
        let alert = UIAlertController(title: "Error".localized,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok".localized, style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
