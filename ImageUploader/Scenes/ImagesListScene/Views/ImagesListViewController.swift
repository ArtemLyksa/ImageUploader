//
//  ImagesListViewController.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

class ImagesListViewController: UIViewController, Errorable {
    
    var presenter: ImagesListPresenter!
    var uploadingPresenter: ImageUploadingPresenter!
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confiureScene()
    }
    
    private func confiureScene() {
        uploadingPresenter.uploadingAssetChanged = { [weak self] indexPath in
            self?.collectionView.reloadItems(at: [indexPath])
        }
        
        uploadingPresenter.errorOccurred = handleError
    }
}

extension ImagesListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.assets.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.getCell(ofType: ImageCollectionViewCell.self, for: indexPath)
        
        presenter.asset(for: indexPath, size: cell.frame.size) { image in
            cell.configure(with: image)
        }
        
        return cell
    }

}

extension ImagesListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        uploadingPresenter.uploadAsset(presenter.assets[indexPath.row],
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
