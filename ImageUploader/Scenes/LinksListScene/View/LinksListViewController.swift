//
//  LinksListViewController.swift
//  ImageUploader
//
//  Created by Artem Lyksa on 5/18/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit

class LinksListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: LinksListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewsOnLoad()
        setupNavigationBar()
    }
    
    private func setupViewsOnLoad() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.tableFooterView = UIView()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Your links".localized
    }
    
}

extension LinksListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.displayedLinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.getCell(ofType: LinkTableViewCell.self)
        cell.configure(with: presenter.displayedLinks[indexPath.row])
        return cell
    }
}

extension LinksListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.selectLink(at: indexPath)
    }
}
