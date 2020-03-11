//
//  AppStoryboard.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit

enum AppStoryboard: String {
    
    case Login
    case TabBar
    case List
    case Map
    case Profile
    
    fileprivate func viewController<T : UIViewController>(viewControllerClass : T.Type) -> T {
        let storyboard = UIStoryboard(name: self.rawValue, bundle: Bundle.main)
        let storyboardID = "\(viewControllerClass as UIViewController.Type)"
        guard let scene = storyboard.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.")
        }
        return scene
    }
}

extension UIViewController {
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
