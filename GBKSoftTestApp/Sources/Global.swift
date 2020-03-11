//
//  Global.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import Foundation

// MARK: - Localization
func localized(_ key: String) -> String {
    let tableName = Defaults.shared.getCurrentLang()
    return NSLocalizedString(key, tableName: tableName, comment: "")
}

// MARK: - Localization
func localizedOptional(_ key: String) -> String? {
    let tableName = Defaults.shared.getCurrentLang()
    let result = NSLocalizedString(key, tableName: tableName, comment: "")
    return result == key ? nil : result
}

