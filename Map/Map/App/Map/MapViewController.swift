//
//  ViewController.swift
//  Map
//
//  Created by Benjamin Lewis on 3/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import CoreLocation
import Mapbox
import UIKit

class MapViewController: UIViewController {
  weak var coordinator: AppCoordinator?

  var currentLocation: CLLocationCoordinate2D? {
    didSet {
      guard let currentLocation = currentLocation else { return }
      mapView.setCenter(currentLocation, animated: true)
    }
  }

  private(set) lazy var mapView: MGLMapView = {
    let mapView = MGLMapView(frame: view.bounds)
    mapView.delegate = self
    mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    mapView.styleURL = URL(string: "mapbox://styles/23inhouse/ck2a8ez6l03801crrht1wx7cz")
    mapView.zoomLevel = 12
    mapView.allowsRotating = false

    return mapView
  }()

  private(set) lazy var locationManager: CLLocationManager = {
    let locationManager = CLLocationManager()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    locationManager.distanceFilter = CLLocationDistance.zero
    locationManager.activityType = CLActivityType.fitness

    return locationManager
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()

    requestLocationPermission()
    requestCurrentLocation()
  }
}

private extension MapViewController {
  func requestLocationPermission() {
    guard CLLocationManager.locationServicesEnabled() else { return }
    locationManager.requestWhenInUseAuthorization()
  }

  func requestCurrentLocation() {
    guard CLLocationManager.locationServicesEnabled() else { return }
    let authorizationStatus = CLLocationManager.authorizationStatus()
    guard [.authorizedWhenInUse, .authorizedAlways].contains(authorizationStatus) else { return }

    locationManager.startUpdatingLocation()
    locationManager.stopUpdatingLocation()
  }

  func setupView() {
    view.addSubview(mapView)
  }
}
