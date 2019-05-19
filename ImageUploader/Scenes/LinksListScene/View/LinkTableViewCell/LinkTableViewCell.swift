//
//  LinkTableViewCell.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/18/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

class LinkTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    func configure(with model: DisplayedLink) {
        label.attributedText = NSAttributedString(string: model.value,
                                                  attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
}
