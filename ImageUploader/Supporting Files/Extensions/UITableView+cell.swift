//
//  UITableView+cell.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

extension UITableView {
    
    func getCell<T>(ofType type: T.Type) -> T {
        
        let nibName = "\(type)"
        
        guard let cell = dequeueReusableCell(withIdentifier: nibName) as? T else {
            register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
            return dequeueReusableCell(withIdentifier: nibName) as! T
        }
        
        return cell
    }
}
