//
//  Closable.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

protocol Closable {
    
    func close()
}

extension Closable where Self: Route {
    
    func close() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
