//
//  TabBarRoute.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

protocol TabBarRoute {
    
    func createTabBar() -> TabBarController
}

extension TabBarRoute {
    
    func createTabBar() -> TabBarController {
        let controller = TabBarController.instantiate(fromAppStoryboard: .TabBar)
        let router = TabBarRouter(viewController: controller)
        let viewModel = TabBarViewModel(router: router)
        controller.viewModel = viewModel
        return controller
    }
}

