//
//  UITableView.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit

extension UITableView {
    
    func dequeueCell<Cell: UITableViewCell>(_ `class`: Cell.Type, for indexPath: IndexPath) -> Cell {
        let cell = dequeueReusableCell(withIdentifier: "\(`class`.self)", for: indexPath)
        // swiftlint:disable force_cast
        return cell as! Cell
        // swiftlint:enable force_cast
    }
    
    func dequeueHeaderFooterView<View: UITableViewHeaderFooterView>(_ `class`: View.Type) -> View {
        let view = dequeueReusableHeaderFooterView(withIdentifier: "\(`class`.self)")
        // swiftlint:disable force_cast
        return view as! View
        // swiftlint:enable force_cast
    }
    
    func registerCell<Cell: UITableViewCell>(_ `class`: Cell.Type, bundle: Bundle = .main) {
        let identifier = "\(`class`.self)"
        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }
    
    func registerHeaderFooterView<View: UITableViewHeaderFooterView>(_ `class`: View.Type, bundle: Bundle = .main) {
        let identifier = "\(`class`.self)"
        register(UINib(nibName: identifier, bundle: bundle), forHeaderFooterViewReuseIdentifier: identifier)
    }
}
