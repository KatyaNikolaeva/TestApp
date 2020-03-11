//
//  ListCell.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit

final class ListCell: CellWithoutBackground {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var latitudeLabel: UILabel!
    @IBOutlet private weak var longitudeLabel: UILabel!
    
    var viewModel: ListCellViewModel? {
        didSet {
            updateCell()
        }
    }
}

// MARK: - Private
private extension ListCell {
    
    func updateCell() {
        nameLabel.text = viewModel?.name
        latitudeLabel.text = String(viewModel?.latitude ?? 0)
        longitudeLabel.text = String(viewModel?.longitude ?? 0)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
    }
    
    @objc func tapAction() {
        viewModel?.tap()
    }
}
