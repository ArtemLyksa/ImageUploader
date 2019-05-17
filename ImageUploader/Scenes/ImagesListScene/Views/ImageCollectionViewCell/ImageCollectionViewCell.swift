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
    
    func configure(with asset: DisplayedAsset) {
        imageView.image = asset.image
    }

}
