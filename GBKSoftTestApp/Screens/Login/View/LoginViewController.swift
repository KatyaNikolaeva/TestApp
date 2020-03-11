//
//  LoginViewController.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 25.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit
import GoogleSignIn

final class LoginViewController: UIViewController {

    @IBOutlet private weak var loginButton: UIButton!
    
    var viewModel: LoginViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ToggleAuthUINotification"), object: nil)
    }
}

// MARK: - View building
private extension LoginViewController {
    
    func setupView() {
        self.title = "GBKSoftTestApp"
        setupLoginButton()
        setupGoogle()
    }
    
    func setupLoginButton() {
        loginButton.setTitle(localized("login.google-button.title"), for: .normal)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    func setupGoogle() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        NotificationCenter.default.addObserver(self, selector: #selector(receiveToggleAuthUINotification(_:)), name: NSNotification.Name(rawValue: "ToggleAuthUINotification"), object: nil)
    }
}

// MARK - Actions
extension LoginViewController {
    
    @objc func login() {
        viewModel.loginWithGoogle()
    }
}

extension LoginViewController {
    
    @objc func receiveToggleAuthUINotification(_ notification: NSNotification) {
        if notification.name.rawValue == "ToggleAuthUINotification" {
            if notification.userInfo != nil {
                guard let userInfo = notification.userInfo as? [String:String] else { return }
                viewModel.setupUserInfoInKeychain(userInfo: userInfo)
            }
        }
    }
}


