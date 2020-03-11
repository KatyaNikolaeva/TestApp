//
//  LoginRoute.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit.UINavigationController

protocol LoginRoute {
    
    func openLogin() -> UINavigationController
}

extension LoginRoute {
    
    func openLogin() -> UINavigationController {
        let viewController = LoginViewController.instantiate(fromAppStoryboard: .Login)
        let router = LoginRouter(viewController: viewController)
        let viewModel = LoginViewModel(router: router)
        viewController.viewModel = viewModel
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}

