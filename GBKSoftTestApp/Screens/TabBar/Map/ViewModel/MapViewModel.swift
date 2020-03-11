//
//  MapViewModel.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

final class MapViewModel {
    
    private weak var view: MapView?
    private let router: MapRouter.Routes
    
    init(view: MapView, router: MapRouter.Routes) {
        self.view = view
        self.router = router
    }
    
    private let api = PointsApi()
}

//MARK: - MapViewModelProtocol
extension MapViewModel: MapViewModelProtocol {
    
    func deletePoint(point: Point) {
        utility { [weak self] in
            self?.api.deletePoint(point: point) { error in
                guard let error = error else { return }
                self?.router.showAlert(error, title: nil, completion: nil)
            }
        }
    }
    
    func setNewPoint(point: Point) {
        utility { [weak self] in
            self?.api.setNewPoint(point: point)
        }
    }
    
    func getPoints() {
        utility { [weak self] in
            self?.api.getPoints(completion: { [weak self] points, error in
                guard let strongSelf = self else { return }
                if let error = error {
                    strongSelf.router.showAlert(error, title: nil, completion: nil)
                } else {
                    strongSelf.view?.setPoints(points: points)
                }
            })
        }
    }
    
    func showAddNewPoinWindow() {
        
    }
}
