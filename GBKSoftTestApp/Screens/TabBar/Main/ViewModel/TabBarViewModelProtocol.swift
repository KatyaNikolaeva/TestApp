//
//  TabBarViewModelProtocol.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit

protocol TabBarViewModelProtocol: AnyObject {
    
    var viewControllers: [UIViewController] { get }
    var images: [String] { get }
    var titles: [String] { get }
}
