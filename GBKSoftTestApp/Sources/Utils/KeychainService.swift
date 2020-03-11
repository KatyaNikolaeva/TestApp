//
//  KeychainService.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import KeychainAccess

final class KeychainService {
    
    static let shared = KeychainService()
    private init() {}
    
    private let service = Keychain(service: "kateryna.nikolaieva.GBKSoftTestApp")
    
    func removeAll() {
        removeUserToken()
    }
}

// MARK: - User token
extension KeychainService {
    
    var isUserSigned: Bool {
        return userToken != nil
    }
    
    // MARK: - User token key
    private var userTokenKey: String {
        return "user_token_key"
    }
    
    func setUserToken(_ value: String) {
        service[userTokenKey] = value
    }
    
    var userToken: String? {
        return service[string: userTokenKey]
    }
    
    private func removeUserToken() {
        service[userTokenKey] = nil
    }
}
