//
//  ListViewController.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

final class ListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: ListViewModelProtocol!
    
    private lazy var tableViewDataSource = ListTableViewDataSource(viewModel: viewModel)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.getPoints()
    }
}

//MARK: - ListView
extension ListViewController: ListView {
    
    func updateData() {
        tableView.reloadData()
    }
}

// MARK: - View building
private extension ListViewController {
    
    func setupView() {
        self.title = localized("list.title")
        setupTableView()
    }
    
    func setupTableView() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = tableViewDataSource
        tableView.registerCell(ListCell.self)
        tableView.registerCell(EmptyListCell.self)
        tableView.tableFooterView = UIView()
    }
}
