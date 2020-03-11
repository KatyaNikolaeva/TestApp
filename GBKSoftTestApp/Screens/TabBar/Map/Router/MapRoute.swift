//
//  MapRoute.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit

protocol MapRoute {
    
    func createMap() -> UINavigationController
    func openMap(selectedPoint: Point)
}

extension MapRoute {
    
    func createMap() -> UINavigationController {
        let viewController = MapViewController.instantiate(fromAppStoryboard: .Map)
        let router = MapRouter(viewController: viewController)
        let viewModel = MapViewModel(view: viewController, router: router)
        viewController.viewModel = viewModel
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}

extension MapRoute where Self: Route {
    
    func openMap(selectedPoint: Point) {
        let viewController = MapViewController.instantiate(fromAppStoryboard: .Map)
        let router = MapRouter(viewController: viewController)
        let viewModel = MapViewModel(view: viewController, router: router)
        viewController.viewModel = viewModel
        viewController.selectedPoint = selectedPoint
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}

