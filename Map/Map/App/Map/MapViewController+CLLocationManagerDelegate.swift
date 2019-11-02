//
//  MapViewController+CLLocationManagerDelegate.swift
//  Map
//
//  Created by Benjamin Lewis on 9/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import CoreLocation
import Foundation

extension MapViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    let isAuthorized = [.authorizedWhenInUse, .authorizedAlways].contains(status)
    mapView.showsUserLocation = isAuthorized
    mapView.showsHeading = isAuthorized
    currentLocation = manager.location?.coordinate
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    currentLocation = manager.location?.coordinate
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Error:", error)
  }
}
