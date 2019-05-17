//
//  ImagesListCoordinator.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

struct ImagesListCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private let viewController: ImagesListViewController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.viewController = ImagesListViewController.instantiate()
        viewController.presenter = ImagesListPresenter(photoService: PhotoService())
        viewController.uploadingPresenter = ImageUploadingPresenter(networkService: NetworkService())
    }
    
    func start() {
        presenter.pushViewController(viewController, animated: true)
    }
}
