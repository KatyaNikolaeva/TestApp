//
//  Thread.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 25.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import Foundation

func main(_ dispatch: @escaping (() -> ())) {
    DispatchQueue.main.async {
        dispatch()
    }
}

func main(after seconds: Double, _ dispatch: @escaping (() -> ())) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        dispatch()
    }
}

func background(_ dispatch: @escaping (() -> ())) {
    DispatchQueue.global(qos: .background).async {
        dispatch()
    }
}

func userInitiated(_ dispatch: @escaping (() -> ())) {
    DispatchQueue.global(qos: .userInitiated).async {
        dispatch()
    }
}

func utility(_ dispatch: @escaping (() -> ())) {
    DispatchQueue.global(qos: .utility).async {
        dispatch()
    }
}
