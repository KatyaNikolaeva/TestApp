//
//  UIViewController.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 01.03.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showMessage(_ text: String) {
        let alert = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

