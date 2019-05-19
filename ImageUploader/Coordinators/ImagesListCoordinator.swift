//
//  ImagesListCoordinator.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

protocol ImagesListNavigationDelegate {
    func navigateToLinksScene()
}

struct ImagesListCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private let viewController: ImagesListViewController
    private let dbService: DataBaseService
    
    init(presenter: UINavigationController, dbService: DataBaseService) {
        self.presenter = presenter
        self.dbService = dbService
        self.viewController = ImagesListViewController.instantiate()
        viewController.navigationDelegate = self
        viewController.listPresenter = ImagesListPresenter(photoService: PhotoService())
        viewController.uploadingPresenter = ImageUploadingPresenter(networkService: NetworkService(),
                                                                    dbService: dbService)
    }
    
    func start() {
        presenter.pushViewController(viewController, animated: true)
    }
}

extension ImagesListCoordinator: ImagesListNavigationDelegate {
    
    func navigateToLinksScene() {
        let linksCoordinator = LinksListCoordinator(presenter: presenter,
                                                    dbService: dbService,
                                                    linkService: LinkService(strategy: SafariLinkStrategy()))
        linksCoordinator.start()
    }
    
}
