//
//  StreetQuality.swift
//  Map
//
//  Created by Benjamin Lewis on 29/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Mapbox

class StreetQuality {
  let qualityIdentifier: String
  let streets: [StreetFilterable]
  let streetQuality: StreetQualitatable

  func draw(on existingLayer: MGLStyleLayer, with style: MGLStyle, as identifier: String) {
    guard streets.count > 0 else { return }
    addLayer(to: style, abover: existingLayer, as: identifier)
    if streetQuality.casingColor != nil {
      addLayer(to: style, abover: existingLayer, as: identifier, isCasing: true)
    }
  }

  init(streets: [StreetFilterable], as streetQuality: StreetQualitatable) {
    self.qualityIdentifier = String(describing: streetQuality)
    self.streets = streetQuality.filter(streets)
    self.streetQuality = streetQuality
  }
}

private extension StreetQuality {
  func addLayer(to style: MGLStyle, abover existingLayer: MGLStyleLayer, as identifier: String, isCasing: Bool = false) {

    let casing = isCasing ? "casing" : ""
    let uniqueIdentifier = [qualityIdentifier, identifier, casing].joined(separator: "-")

    let layer = StreetLayer(uniqueIdentifier, on: style, with: streets)
    layer.decorator = streetQuality
    layer.applyStyles(isCasing: isCasing)

    style.insertLayer(layer, above: existingLayer)
  }
}

extension StreetQuality {
  static func make(from streets: [StreetFilterable]) -> [StreetQuality] {
    let qualityTypes: [StreetQualitatable] = [
      CycleStreetQuality(), CycleWayQuality(), CycleWaySmallQuality(),
      CycleTrackQuality(), CycleLaneQuality(),
      CycleSharedFastQuality(), CycleSharedQuality(), CyclePathQuality(),
      CycleWayRoughQuality(), CycleWayUnknownQuality(),

      CobblestoneQuality(),
    ]

    return qualityTypes.map { qualityType in
      StreetQuality(streets: streets, as: qualityType)
    }
  }
}
