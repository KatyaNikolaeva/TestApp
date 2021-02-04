//
//  POIItem.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 15.03.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import GoogleMapsUtils

final class POIItem: NSObject, GMUClusterItem {
    
    var position: CLLocationCoordinate2D
    var name: String
    var icon: UIImage
    
    init(position: CLLocationCoordinate2D, name: String, icon: UIImage) {
        self.position = position
        self.name = name
        self.icon = icon
    }
}
