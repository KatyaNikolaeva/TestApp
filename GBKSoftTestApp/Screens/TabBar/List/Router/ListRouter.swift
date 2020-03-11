//
//  ListRouter.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

final class ListRouter: Router<ListViewController>, ListRouter.Routes {

    typealias Routes = Closable & TabBarRoute & AlertRoute & SpinnerRoute & MapRoute
    
    private var spinner: SpinnerViewController?
    
    func showSpinner() {
        spinner = SpinnerViewController()
        spinner?.modalPresentationStyle = .overFullScreen
        spinner?.modalTransitionStyle = .crossDissolve
        viewController?.present(spinner!, animated: true, completion: nil)
    }
    
    func hideSpinner() {
        spinner?.dismiss(animated: true, completion: nil)
    }
}

