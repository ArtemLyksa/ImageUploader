//
//  LinkService.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/19/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

protocol LinkStrategy {
    func open(link: URL)
}

struct LinkService {
    private let strategy: LinkStrategy
    
    init(strategy: LinkStrategy) {
        self.strategy = strategy
    }
    
    func open(link: URL) {
        strategy.open(link: link)
    }
}

struct SafariLinkStrategy: LinkStrategy {
    
    func open(link: URL) {
        UIApplication.shared.open(link)
    }
}

