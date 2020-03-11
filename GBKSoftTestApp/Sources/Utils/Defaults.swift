//
//  Defaults.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import Foundation

final class Defaults {
    
    static let shared = Defaults()
    private init() {}
    
    private let preferences = UserDefaults(suiteName: "GBKSoftTestApp defaults")!
    
    private func resetAll() {
        resetLang()
        KeychainService.shared.removeAll()
    }
    
    private func apply() {
        preferences.synchronize()
    }
}

// MARK: - Lang
extension Defaults {
    
    var defaultLangKey: String {
        return "en"
    }
    
    private var currentLangKey: String {
        return "current_lang"
    }
    
    func getCurrentLang() -> String {
        return preferences.string(forKey: currentLangKey) ?? defaultLangKey
    }
    
    private func setCurrentLang(_ code: String) {
        preferences.set(code, forKey: currentLangKey)
        apply()
    }
    
    func resetLang() {
        var langCode = Utils.shared.getSystemLang()
        langCode = String(langCode.prefix(2))
        switch langCode {
        case "en":
            setCurrentLang(langCode)
        default:
            setCurrentLang(defaultLangKey)
        }
    }
}

