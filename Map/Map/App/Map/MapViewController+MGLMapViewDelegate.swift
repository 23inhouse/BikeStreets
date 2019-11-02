//
//  MapViewController+MGLMapViewDelegate.swift
//  Map
//
//  Created by Benjamin Lewis on 9/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Foundation
import Mapbox

extension MapViewController: MGLMapViewDelegate {
  func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
    return true
  }

  func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
    let camera = MGLMapCamera(lookingAtCenter: annotation.coordinate, altitude: 4500, pitch: 15, heading: 180)
    mapView.fly(to: camera, withDuration: 4, peakAltitude: 3000, completionHandler: nil)
  }
}
