//
//  ProfileViewModel.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

final class ProfileViewModel: ProfileViewModelProtocol {
    
    func logout() {
        Coordinator.shared.logout()
    }
}
