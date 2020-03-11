//
//  TabBarViewModel.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit

final class TabBarViewModel {
    
    private let router: TabBarRouter.Routes
    
    init(router: TabBarRouter.Routes) {
        self.router = router
    }
}

// MARK: - TabBarViewModelProtocol
extension TabBarViewModel: TabBarViewModelProtocol {
    
    var viewControllers: [UIViewController] {
        return router.viewControllers
    }
    
    var images: [String] {
        return router.images
    }
    
    var titles: [String] {
        return router.titles
    }
}
