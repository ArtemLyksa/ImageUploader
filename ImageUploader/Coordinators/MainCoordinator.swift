//
//  MainCoordinator.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

struct MainCoordinator: Coordinator {
    
    private weak var window: UIWindow?
    private let rootViewController: UINavigationController
    private let imagesListCoordinator: ImagesListCoordinator
    
    init(window: UIWindow?, dbService: DataBaseService) {
        self.window = window
        self.rootViewController = UINavigationController()
        self.imagesListCoordinator = ImagesListCoordinator(presenter: rootViewController, dbService: dbService)
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
