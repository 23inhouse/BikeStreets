//
//  MapViewController.swift
//  Map
//
//  Created by Benjamin Lewis on 3/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import CoreLocation
import Mapbox
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import UIKit

class MapViewController: UIViewController {
  weak var coordinator: AppCoordinator?

  var directionsRoute: Route?

  var currentLocation: CLLocationCoordinate2D? {
    didSet {
      guard var currentLocation = currentLocation else { return }
      let latitude = currentLocation.latitude
      let zoomLevel = mapView.zoomLevel
      let adjustment = getAdjustment(latitude: latitude, zoomLevel: zoomLevel)
      currentLocation.latitude -= adjustment
      mapView.setCenter(currentLocation, animated: true)
    }
  }

  private lazy var controlsViewController: ControlsViewController = {
    let controlsViewController = ControlsViewController()
    controlsViewController.coordinator = coordinator
    controlsViewController.mapDelegate = self
    return controlsViewController
  }()

  private(set) lazy var mapView: MGLMapView = {
    let mapView = MGLMapView(frame: view.bounds)
    mapView.delegate = self
    mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    mapView.styleURL = URL(string: "mapbox://styles/23inhouse/ck2pi4s1j1fb51cn3p0yywo2j")
    mapView.zoomLevel = 12
    mapView.allowsRotating = false
    mapView.allowsTilting = false
    mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 52.516, longitude: 13.3885)

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

  func setLocationToCurrent() {
    requestLocationPermission()
    requestCurrentLocation()
    currentLocation = locationManager.location?.coordinate
  }

  func route(from origin: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
    setLocationToCurrent()
    calculateRoute(from: origin, to: destination) { (_, error) in
      if error != nil {
        print("Error calculating route")
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
}

private extension MapViewController {
  func getAdjustment(latitude: CLLocationDegrees, zoomLevel: Double) -> Double {
    let resolution = 156543.03 * cos(latitude) / pow(2, zoomLevel)
    let dpi = 362.0
    let scale = dpi * (1.0 / 0.0254) * resolution
    let adjustment = abs(4.0 * scale / 100_000_000)

    return adjustment
  }

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
    add(controlsViewController, to: view)
  }
}

private extension MapViewController {
  func calculateRoute(from origin: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping (Route?, Error?) -> Void) {

    let origin = Waypoint(coordinate: origin, coordinateAccuracy: 25, name: "Start")
    let destination = Waypoint(coordinate: destination, coordinateAccuracy: 25, name: "Finish")

    let options = NavigationRouteOptions(waypoints: [origin, destination], profileIdentifier: .cycling)
    options.includesAlternativeRoutes = true

    _ = Directions.shared.calculate(options) { [unowned self] (_, routes, _) in
      guard let routes = routes else { return }
      self.drawRoute(routes: routes)
    }
  }

  func drawRoute(routes: [Route]) {
    print("number of routes:", routes.count)
    for (i, route) in routes.enumerated() {
      let identifier = "route-\(i)"

      guard route.coordinateCount > 0 else { return }
      guard let routeCoordinates = route.coordinates else { return }

      let polyline = MGLPolylineFeature(coordinates: routeCoordinates, count: route.coordinateCount)

      if let source = mapView.style?.source(withIdentifier: "\(identifier)-source") as? MGLShapeSource {
        source.shape = polyline
      } else {
        let source = MGLShapeSource(identifier: "\(identifier)-source", features: [polyline], options: nil)

        let widthFormat = "mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'exponential', 1.5, %@)"
        let stops = [
          7: 0,
          8: 1,
          19: 6,
          22: 10,
        ]

        let lineStyle = MGLLineStyleLayer(identifier: "\(identifier)-style", source: source)
        lineStyle.lineColor = NSExpression(forConstantValue: #colorLiteral(red: 0.07096435875, green: 0.2837115526, blue: 0.6452264786, alpha: 1))
        lineStyle.lineWidth = NSExpression(format: widthFormat, stops)
        lineStyle.lineJoin = NSExpression(forConstantValue: "round")
        lineStyle.lineCap = NSExpression(forConstantValue: "round")

        mapView.style?.addSource(source)
        mapView.style?.addLayer(lineStyle)
      }
    }
  }
}
