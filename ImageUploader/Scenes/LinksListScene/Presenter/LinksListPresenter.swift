//
//  LinksListPresenter.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/18/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import Foundation

class LinksListPresenter {
    
    private let dbService: DataBaseService
    lazy var displayedLinks: [DisplayedLink] = {
        return self.dbService.fetchLinks().map({ DisplayedLink(with: $0) })
    }()
    
    init(dbService: DataBaseService) {
        self.dbService = dbService
    }
    
}
