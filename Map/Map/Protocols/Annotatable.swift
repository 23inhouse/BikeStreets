//
//  Annotatable.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import MapKit
import Mapbox

protocol Annotatable {
  var annotations: [MGLPointAnnotation]? { get }
  var mapView: MGLMapView? { get }

  func annotate()
}

extension Annotatable {
  func annotate() {
    guard let mapView = mapView else { return }

    if let annotations = mapView.annotations {
      mapView.removeAnnotations(annotations)
    }

    if let annotations = annotations {
      mapView.addAnnotations(annotations)
    }
  }

  func makeAnnotations(from mapItems: [MKMapItem]) -> [MGLPointAnnotation] {
    let annotations = mapItems.map { mapItem -> MGLPointAnnotation in
      let placemark = mapItem.placemark
      let annotation = MGLPointAnnotation()
      annotation.coordinate = placemark.coordinate
      annotation.title = placemark.name
      annotation.subtitle = placemark.title
      return annotation
    }
    return annotations
  }
}
