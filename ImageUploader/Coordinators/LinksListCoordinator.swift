//
//  LinksListCoordinator.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/18/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

struct LinksListCoordinator: Coordinator {
    
    private let presenter: UINavigationController
    private let viewController: LinksListViewController
    
    init(presenter: UINavigationController, dbService: DataBaseService) {
        self.presenter = presenter
        self.viewController = LinksListViewController.instantiate()
        viewController.presenter = LinksListPresenter(dbService: dbService)
    }
    
    func start() {
        presenter.pushViewController(viewController, animated: true)
    }
}
