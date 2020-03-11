//
//  MapViewModelProtocol.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import GoogleMaps

protocol MapViewModelProtocol {
    
    func getPoints()
    func setNewPoint(point: Point)
    func deletePoint(point: Point)
}
