//
//  AlertRoute.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit.UIAlertController

protocol AlertRoute {
    
    func showAlert(_ text: String, title: String?, completion: Action?)
}

extension AlertRoute where Self: Route {
    
    func showAlert(_ text: String, title: String?, completion: Action?) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        viewController?.present(alert, animated: true, completion: nil)
    }
}

extension AlertRoute where Self: RouteWithParent {
    
    func showAlert(_ text: String, title: String?, completion: (() -> ())?) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: localized("ok"), style: .default, handler: { _ in
            completion?()
        }))
        self.viewController?.present(alert, animated: true, completion: nil)
    }
}
