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

  func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
    loadData(in: style)
  }
}

private extension MapViewController {
  func loadData(in style: MGLStyle, on layerName: String = "cycleway") {
    guard let cyclewayLayer = style.layer(withIdentifier: layerName) else {
      print("Error: Couldn't find the layer named \(layerName)")
      return
    }

    func handleWay(_ resource: String, _ style: MGLStyle, _ osmWays: [OSMWay]) {
      DispatchQueue.main.sync {
        print("Loaded:", resource, "- Found:", osmWays.count)

        let streetQualities = StreetQuality.make(from: osmWays)
        streetQualities.forEach { streetQuality in
          streetQuality.draw(on: cyclewayLayer, with: style, as: resource)
        }
      }
    }

    DispatchQueue.global(qos: .background).async {
      let resources = ["stralsund", "budapest", "berlin", "amsterdam", "copenhagen", "newyork", "portland", "montreal"]
      API.fetchWays(for: resources, style: style, completion: handleWay)
    }
  }
}
