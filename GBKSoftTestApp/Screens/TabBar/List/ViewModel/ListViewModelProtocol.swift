//
//  ListViewModelProtocol.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

protocol ListViewModelProtocol: AnyObject {
    
    var cells: [ListCellType] { get }
    func getPoints()
}
