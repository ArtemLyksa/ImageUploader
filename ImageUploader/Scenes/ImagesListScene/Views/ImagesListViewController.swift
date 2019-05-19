//
//  ImagesListViewController.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

class ImagesListViewController: UIViewController, Errorable {
    
    var listPresenter: ImagesListPresenter!
    var uploadingPresenter: ImageUploadingPresenter!
    var navigationDelegate: ImagesListNavigationDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScene()
        setupNavigationBar()
    }
    
    private func configureScene() {
        listPresenter.assetsChangedHandler = {
            OperationQueue.main.addOperation({ [weak self] in
                self?.collectionView.reloadData()
            })
        }

        uploadingPresenter.uploadingAssetChanged = { indexPath in
            OperationQueue.main.addOperation({ [weak self] in
                self?.collectionView.reloadItems(at: [indexPath])
            })
        }
        uploadingPresenter.errorOccurred = handleError
    }
    
    private func setupNavigationBar() {
        let linksBarButton = UIBarButtonItem(title: "Links".localized,
                                             style: .plain,
                                             target: self,
                                             action: #selector(linksBarButtonAction(sender:)))
        navigationItem.rightBarButtonItem = linksBarButton
        
        navigationItem.title = "Your photos".localized
    }
    
     @objc private func linksBarButtonAction(sender: UIBarButtonItem) {
        navigationDelegate?.navigateToLinksScene()
    }
}

extension ImagesListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listPresenter.assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.getCell(ofType: ImageCollectionViewCell.self, for: indexPath)
        
        listPresenter.asset(for: indexPath, size: cell.frame.size) { image in
            cell.configure(with: image)
        }
        
        return cell
    }
}

extension ImagesListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        uploadingPresenter.uploadAsset(listPresenter.assets[indexPath.row],
                                       indexPath: indexPath)
    }
}

extension ImagesListViewController: UICollectionViewDelegateFlowLayout {
    
    
    private var multiplier: CGFloat {
        return view.frame.width > view.frame.height ? 5 : 3
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width = collectionView.frame.width
        
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            width -= flowLayout.minimumLineSpacing * multiplier
            width /= multiplier
        }
        
        return CGSize(width: width, height: width)
    }
}
