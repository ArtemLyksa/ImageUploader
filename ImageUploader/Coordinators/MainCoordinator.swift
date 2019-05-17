//
//  MainCoordinator.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

struct MainCoordinator: Coordinator {
    
    private let rootViewController: UINavigationController
    
    private let window: UIWindow?
    private let imagesListCoordinator: ImagesListCoordinator
    
    init(window: UIWindow?) {
        self.window = window
        self.rootViewController = UINavigationController()
        self.imagesListCoordinator = ImagesListCoordinator(presenter: rootViewController)
    }
    
    func start() {
        guard let window = window else {
            return
        }
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        imagesListCoordinator.start()
    }
}
