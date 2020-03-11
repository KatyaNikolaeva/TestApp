//
//  TabBarRouter.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit

protocol TabBarRouterProtocol: AnyObject {
    
    var viewControllers: [UIViewController] { get }
    var images: [String] { get }
    var titles: [String] { get }
}

final class TabBarRouter: Router<TabBarController>, TabBarRouter.Routes {
    
    typealias Routes = TabBarRouterProtocol & ListRoute & ProfileRoute & MapRoute
    
    private lazy var list = createList()
    private lazy var map = createMap()
    private lazy var profile  = createProfile()
    
    var viewControllers: [UIViewController] {
        return [list, map, profile]
    }
    
    var images: [String] {
        return ["icons8-map-pinpoint-50", "icons8-map-50", "icons8-user-50"]
    }
    
    var titles: [String] {
        return [localized("list.title"), localized("map.title"), localized("profile.title")]
    }
}
