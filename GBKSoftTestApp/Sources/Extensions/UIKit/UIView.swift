//
//  UIView.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit

extension UIView {
    
    func setShadow(opacity: Float, color: UIColor, radius: CGFloat, offset: CGSize = CGSize.zero) {
        layer.masksToBounds = false
        layer.shadowOpacity = opacity
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOffset = offset
    }
}
