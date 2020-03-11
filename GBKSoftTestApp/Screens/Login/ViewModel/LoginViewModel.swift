//
//  LoginViewModel.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import GoogleSignIn

final class LoginViewModel {

    private let router: LoginRouter.Routes
    
    init(router: LoginRouter.Routes) {
        self.router = router
    }
}

// MARK: - LoginViewModelProtocol
extension LoginViewModel: LoginViewModelProtocol {
    
    func setupUserInfoInKeychain(userInfo: [String: String]) {
        guard let token = userInfo["idToken"] else {
            self.router.showAlert(localized("error.with.google.auth"), title: nil, completion: nil)
            return
        }
        KeychainService.shared.setUserToken(token)
        Coordinator.shared.presentInititalScreen()
    }
    
    func loginWithGoogle() {
        GIDSignIn.sharedInstance().signIn()
    }
}
