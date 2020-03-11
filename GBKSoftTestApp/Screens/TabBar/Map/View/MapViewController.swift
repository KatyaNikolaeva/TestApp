//
//  MapViewController.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 29.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase
import CodableFirebase

final class MapViewController: UIViewController {

    private var mapView: GMSMapView?
    private var locationManager = CLLocationManager()
    
    var viewModel: MapViewModelProtocol!
    private var mapPoints = [Point]()
    
    var selectedPoint: Point?
    
    override func loadView() {
        super.loadView()
        mapView = GMSMapView()
        createMap()
        viewModel.getPoints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getPoints()
    }
}

//MARK: - MapView
extension MapViewController: MapView {
    func setPoints(points: [Point]) {
        mapPoints = points
        setupUserMarker(points: points)
    }
}

// MARK: - View building
private extension MapViewController {
    
    func setupView() {
        self.title = localized("map.title")
    }
    
    func createMap() {
        view = mapView
        mapView?.delegate = self
        mapView?.isMyLocationEnabled = true
        mapView?.settings.myLocationButton = true
        mapView?.padding = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 30)
        setupLocationManager()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func setupUserMarker(points: [Point]) {
        mapView?.clear()
        for point in points {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
            marker.title = point.name
            marker.map = mapView
            checkSelectedPoint(point: point, marker: marker)
            marker.icon = UIImage(named: "icons8-heart-64")
        }
    }
    
    func checkSelectedPoint(point: Point, marker: GMSMarker) {
        if let selectedPoint = selectedPoint, selectedPoint.name == point.name {
            mapView?.selectedMarker = marker
            let camera = GMSCameraPosition.camera(withLatitude: point.latitude, longitude: point.longitude, zoom: 17.0)
            mapView?.animate(to: camera)
        }
    }
}

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
        guard let name = marker.title else { return }
        let arrayWithSelectedPoint = mapPoints.filter({ $0.name == name })
       
        guard let element = arrayWithSelectedPoint[safe: 0] else { return }
        marker.map = nil
        viewModel.deletePoint(point: element)
        viewModel.getPoints()
    }

    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        showAddPointWindow(coordinate: coordinate)
    }

    private func showAddPointWindow(coordinate: CLLocationCoordinate2D) {
        let alertController = UIAlertController(title: localized("map.alert.title"), message: localized("map.alert.description"), preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = localized("map.alert.textfield.title")
        }
        alertController.addAction(UIAlertAction(title: localized(localized("save")), style: .default, handler: { [weak self] alert -> Void in
            guard let strongSelf = self else { return }
            let textField = alertController.textFields![0] as UITextField
            guard let textFromTextField = textField.text, !textFromTextField.isEmpty, textFromTextField != "" else { return }
            strongSelf.viewModel.setNewPoint(point: Point(name: textFromTextField, latitude: coordinate.latitude, longitude: coordinate.longitude))
        }))
        alertController.addAction(UIAlertAction(title: localized("cancel"), style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension MapViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mapView = self.mapView, let location = locations.last else { return }

        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 17.0)

        mapView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
    }
}
