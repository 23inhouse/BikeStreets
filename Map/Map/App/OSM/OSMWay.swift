//
//  OSMWay.swift
//  Map
//
//  Created by Benjamin Lewis on 25/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import CoreLocation

class OSMWay {
  let id: UInt
  let name: String?
  let bicycle: Bool
  let cycleway: CyclewayType
  let highway: HighwayType
  let smoothness: SmoothnessType
  let surface: SurfaceType
  let surfaceColor: Bool

  var coordinates = [CLLocationCoordinate2D]()

  init(id: UInt, name: String? = nil, bicycle: Bool?, cycleway: CyclewayType?, highway: HighwayType?, smoothness: SmoothnessType?, surface: SurfaceType?, surfaceColor: Bool?) {
    self.id = id
    self.name = name
    self.bicycle = bicycle ?? false
    self.cycleway = cycleway ?? .unknown
    self.highway = highway ?? .unknown
    self.smoothness = smoothness ?? .unknown
    self.surface = surface ?? .unknown
    self.surfaceColor = surfaceColor ?? false
  }
}
