//
//  Utils.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import Foundation

final class Utils {
    
    static let shared = Utils()
    private init() {}
    
    func getSystemLang() -> String {
        return NSLocale.preferredLanguages[0]
    }
}
