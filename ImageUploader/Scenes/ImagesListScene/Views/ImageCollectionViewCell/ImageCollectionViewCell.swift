//
//  ImageCollectionViewCell.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/17/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    func configure(with asset: DisplayedAsset) {
        imageView.image = asset.image
        configure(with: asset as Uploadable)
    }
    
    private func configure(with uploadingAsset: Uploadable) {
        if uploadingAsset.state == .uploading {
            activityIndicatorView.startAnimating()
            activityIndicatorView.isHidden = false
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
}
