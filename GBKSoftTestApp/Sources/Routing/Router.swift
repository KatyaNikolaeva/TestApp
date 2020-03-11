//
//  Router.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit

protocol Route: AnyObject {
    
    associatedtype ViewController where ViewController: UIViewController
    
    var viewController: ViewController? { get }
    init(viewController: ViewController)
    
}

class Router<ViewController: UIViewController>: NSObject, Route {
    
    weak var viewController: ViewController?
    required init(viewController: ViewController) {
        self.viewController = viewController
    }
}

protocol RouteWithParent: AnyObject {
    
    associatedtype ViewController where ViewController: UIViewController
    
    var parent: UIViewController? { get }
    var viewController: ViewController? { get }
    init(parent: UIViewController?, viewController: ViewController)
    
    var showErrorInParent: ((String) -> Void)? { get set }
}

class RouterWithParent<ViewController: UIViewController>: RouteWithParent {
    
    weak var parent: UIViewController?
    weak var viewController: ViewController?
    
    required init(parent: UIViewController?, viewController: ViewController) {
        self.parent = parent
        self.viewController = viewController
    }
    
    var showErrorInParent: ((String) -> Void)?
}
