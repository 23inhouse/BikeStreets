//
//  StreetFilterable.swift
//  Map
//
//  Created by Benjamin Lewis on 29/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import CoreLocation

protocol StreetFilterable {
  var coordinates: [CLLocationCoordinate2D] { get set }
  var bicycle: Bool { get }
  var cycleway: CyclewayType { get }
  var highway: HighwayType { get }
  var smoothness: SmoothnessType { get }
  var surface: SurfaceType { get }
  var surfaceColor: Bool { get }
}
