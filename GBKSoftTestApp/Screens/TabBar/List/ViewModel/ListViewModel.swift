//
//  ListViewModel.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

final class ListViewModel {
    
    private weak var view: ListView?
    private let router: ListRouter.Routes
    
    init(view: ListView, router: ListRouter.Routes) {
        self.view = view
        self.router = router
    }
    
    private let api = PointsApi()
    
    private var points = [Point]() {
        didSet {
            self.view?.updateData()
        }
    }
}

//MARK: - ListViewModelProtocol
extension ListViewModel: ListViewModelProtocol {
    
    func getPoints() {
        utility { [weak self] in
            self?.showLoading()
            self?.api.getPoints(completion: { [weak self] points, error in
                guard let strongSelf = self else { return }
                if let _ = error {
                    self?.hideLoading()
                } else {
                    strongSelf.points = points.sorted(by: { $0.name < $1.name })
                    self?.hideLoading()
                }
            })
        }
    }
    
    var cells: [ListCellType] {
        return getListCells()
    }
}

private extension ListViewModel {
    
    func getListCells() -> [ListCellType] {
        var listCells = [ListCellType]()
        if points.isEmpty {
            listCells.append(.empty)
        } else {
            for item in points {
                listCells.append(.point(ListCellViewModel(name: item.name, latitude: item.latitude, longitude: item.longitude, tap: { [weak self] in
                    self?.router.openMap(selectedPoint: item)
                })))
            }
        }
        return listCells
    }
    
    func showLoading() {
        main { [weak self] in
            self?.router.showSpinner()
        }
    }
    
    func hideLoading() {
        main { [weak self] in
            self?.router.hideSpinner()
        }
    }
}
