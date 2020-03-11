//
//  ProfileRoute.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit

protocol ProfileRoute {
    
    func createProfile() -> UINavigationController
}

extension ProfileRoute {
    
    func createProfile() -> UINavigationController {
        let viewController = ProfileViewController.instantiate(fromAppStoryboard: .Profile)
        let viewModel = ProfileViewModel()
        viewController.viewModel = viewModel
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}


