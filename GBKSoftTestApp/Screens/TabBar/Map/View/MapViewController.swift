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
import GoogleMapsUtils

final class MapViewController: UIViewController {

    private var mapView: GMSMapView?
    private var locationManager = CLLocationManager()
    private var clusterManager: GMUClusterManager?
    
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
        initializeClusterItems()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func setupUserMarker(points: [Point]) {
        mapView?.clear()
        var index = 0
        for point in points {
            let marker = GMSMarker()
            let coordinate = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
            marker.position = coordinate
            marker.title = point.name
            marker.map = mapView
            marker.userData = point
            checkSelectedPoint(point: point, marker: marker)
            self.generatePOIItems(String(format: "%d", index), position: coordinate, icon: UIImage(named: "heart-64"))
            index += 1
        }
    }
    
    func checkSelectedPoint(point: Point, marker: GMSMarker) {
        if let selectedPoint = selectedPoint, selectedPoint.name == point.name {
            mapView?.selectedMarker = marker
            let camera = GMSCameraPosition.camera(withLatitude: point.latitude, longitude: point.longitude, zoom: 17.0)
            mapView?.animate(to: camera)
        }
    }
    
    //MARK: - Init cluster items
    func initializeClusterItems() {
        guard let mapView = mapView else { return }
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUGridBasedClusterAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        self.clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        var markers = [GMUClusterItem]()
        mapPoints.forEach({ point in
    
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude))
            if let clusterItem = marker as? GMUClusterItem {
                markers.append(clusterItem)
            }
        })
        self.clusterManager?.add(markers)
        self.clusterManager?.cluster()
        self.clusterManager?.setDelegate(self, mapDelegate: self)
    }
}


extension MapViewController: GMUClusterManagerDelegate {
    
    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
        guard let mapView = mapView else { return false }
        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position,
        zoom: mapView.camera.zoom + 1)
        let update = GMSCameraUpdate.setCamera(newCamera)
        mapView.moveCamera(update)
        return false
    }
    
    func generatePOIItems(_ accessibilityLabel: String, position: CLLocationCoordinate2D, icon: UIImage?) {
        guard let icon = icon else { return }
        let item = POIItem(position: position, name: accessibilityLabel, icon: icon)
        self.clusterManager?.add(item)
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
