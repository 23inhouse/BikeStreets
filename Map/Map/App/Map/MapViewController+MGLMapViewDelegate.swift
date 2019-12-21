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
    return false
  }

  func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
    coordinator?.show(panel: .search, position: .half, annotation: annotation)
  }

  func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
    loadData(in: style)
  }
}

private extension MapViewController {
  func loadData(in style: MGLStyle, on layerName: String = "cycleway-dynamic") {
    guard let cyclewayLayer = style.layer(withIdentifier: layerName) else {
      print("Error: Couldn't find the layer named \(layerName)")
      return
    }

    guard let coordinator = coordinator else { return }

    for (resource, streetQualities) in coordinator.resources {
      DispatchQueue.global(qos: .background).async {
        streetQualities.forEach { streetQuality in
          DispatchQueue.main.sync {
            streetQuality.draw(on: cyclewayLayer, with: style, as: resource)
          }
        }
      }
    }
  }
}
