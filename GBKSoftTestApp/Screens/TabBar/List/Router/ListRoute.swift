//
//  ListRoute.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit

protocol ListRoute {
    
    func createList() -> UINavigationController
}

extension ListRoute {
    
    func createList() -> UINavigationController {
        let viewController = ListViewController.instantiate(fromAppStoryboard: .List)
        let router = ListRouter(viewController: viewController)
        let viewModel = ListViewModel(view: viewController, router: router)
        viewController.viewModel = viewModel
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}

