//
//  OSMDataBridge.swift
//  Map
//
//  Created by Benjamin Lewis on 23/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Foundation

struct OSMDataBridge {
  let osmRawData: OSMRawData?

  func make() -> [OSMWay]? {
    guard let osmRawData = osmRawData else { return nil }

    var osmWays: [OSMWay] = []
    for element in osmRawData.elements where (element.geometry != nil && element.geometry?.count ?? 0 > 0) {
      let bridge = OSMElementToWayBridge(osmRawElement: element)
      guard let osmWay = bridge.make() else { continue }
      osmWays.append(osmWay)
    }

    return osmWays
  }
}
