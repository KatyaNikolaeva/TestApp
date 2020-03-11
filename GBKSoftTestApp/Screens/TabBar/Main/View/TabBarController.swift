//
//  TabBarController.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 25.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
    
    var viewModel: TabBarViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

private extension TabBarController {
    
    func setupView() {
        addTabs()
        tabBar.setShadow(opacity: 0.1, color: .black, radius: 10)
    }
    
    func addTabs() {
        viewControllers = viewModel.viewControllers
        
        for index in 0..<viewModel.viewControllers.count {
            if let name = viewModel.images[safe: index] {
                tabBar.items![index].image = UIImage(named: name)
            } else {
                tabBar.items![index].image = nil
            }
            tabBar.items![index].title = viewModel.titles[safe: index]
        }
    }
    
}
