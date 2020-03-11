//
//  Popable.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

protocol Popable {
    
    func pop()
}

extension Popable where Self: Route {
    
    func pop() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
