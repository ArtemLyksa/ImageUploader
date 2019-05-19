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
    private let linkService: LinkService
    
    lazy var displayedLinks: [DisplayedLink] = {
        return self.dbService.fetchLinks().map({ DisplayedLink(with: $0) })
    }()
    
    init(dbService: DataBaseService, linkService: LinkService) {
        self.dbService = dbService
        self.linkService = linkService
    }
    
    func selectLink(at indexPath: IndexPath) {
        guard let url = URL(string: displayedLinks[indexPath.row].value) else {
            return
        }
        linkService.open(link: url)
    }
}
