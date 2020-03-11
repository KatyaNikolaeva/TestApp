//
//  ProfileViewController.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {

    @IBOutlet private weak var logoutButton: UIButton!
    
    var viewModel: ProfileViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - View building
private extension ProfileViewController {
    
    func setupView() {
        self.title = localized("profile.title")
        setupButton()
    }
    
    func setupButton() {
        logoutButton.setTitle(localized("profile.logout-button.title"), for: .normal)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
}

// MARK: - Actions
private extension ProfileViewController {
    
    @objc func logout() {
        viewModel.logout()
    }
}

