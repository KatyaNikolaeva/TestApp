//
//  ListTableViewDataSource.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit

final class ListTableViewDataSource: NSObject {
    
    private weak var viewModel: ListViewModelProtocol?
    init(viewModel: ListViewModelProtocol) {
        self.viewModel = viewModel
    }
}

// MARK: - UITableViewDataSource
extension ListTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        guard let item = viewModel.cells[safe: indexPath.row] else { return UITableViewCell() }
        switch item {
        case .empty:
            let cell = tableView.dequeueCell(EmptyListCell.self, for: indexPath)
            return cell
        case let .point(listCellViewModel):
            let cell = tableView.dequeueCell(ListCell.self, for: indexPath)
            cell.viewModel = listCellViewModel
            return cell
        }
    }
}
