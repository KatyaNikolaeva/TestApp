//
//  Coordinator.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit
import GoogleSignIn

final class Coordinator: Coordinator.Routes {
    
    static let shared = Coordinator()
    private init() {}
    
    typealias Routes = LoginRoute & TabBarRoute
    private weak var window: UIWindow?
    
    func setWindow(_ window: UIWindow) {
        self.window = window
    }
    
    func showTabBar() {
        let tabBar = createTabBar()
        setupFadeTransition(window: window)
        window?.rootViewController = tabBar
    }
    
    func presentInititalScreen() {
        let viewController: UIViewController
        if KeychainService.shared.isUserSigned {
            viewController = createTabBar()
        } else {
            viewController = openLogin()
        }
        setupFadeTransition(window: window)
        window?.rootViewController = viewController
    }
    
    func logout() {
        KeychainService.shared.removeAll()
        GIDSignIn.sharedInstance().signOut()
        presentInititalScreen()
    }
}

private extension Coordinator {
    
    private func setupFadeTransition(window: UIWindow?) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromBottom
        window?.layer.add(transition, forKey: kCATransition)
    }
}

// MARK: - TopViewController
extension Coordinator {
    
    func topMostViewController(in application: UIApplication) -> UIViewController? {
        guard let rootViewController = application.keyWindow?.rootViewController else {
            return nil
        }
        return topViewController(for: rootViewController)
    }
    
    var topMostViewController: UIViewController? {
        guard let rootViewController = window?.rootViewController else {
            return nil
        }
        return topViewController(for: rootViewController)
    }
    
    func topViewController(for rootViewController: UIViewController?) -> UIViewController? {
        switch rootViewController {
        case let navigationController as UINavigationController where !navigationController.viewControllers.isEmpty:
            return topViewController(for: navigationController.visibleViewController)
        case let tabBarController as UITabBarController where tabBarController.selectedViewController != nil:
            return topViewController(for: tabBarController.selectedViewController)
        default:
            if let presentedViewController = rootViewController?.presentedViewController {
                return topViewController(for: presentedViewController)
            } else {
                return rootViewController
            }
        }
    }
}
