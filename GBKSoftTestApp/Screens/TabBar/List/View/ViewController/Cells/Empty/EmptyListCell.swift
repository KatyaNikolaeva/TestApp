//
//  EmptyListCell.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 01.03.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit

final class EmptyListCell: CellWithoutBackground {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = localized("list.empty.title")
    }
}
