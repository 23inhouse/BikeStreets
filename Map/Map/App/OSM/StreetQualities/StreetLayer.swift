//
//  StreetLayer.swift
//  Map
//
//  Created by Benjamin Lewis on 29/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Mapbox

class StreetLayer: MGLLineStyleLayer {
  var decorator: StreetQualitatable = CycleUnknownQuality()

  var widthFormat = "mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'exponential', 1.5, %@)"

  func applyStyles(isCasing: Bool) {
    let color = isCasing ? decorator.casingColor : decorator.color

    lineColor = NSExpression(forConstantValue: color)
    lineWidth = NSExpression(format: widthFormat, stops(isCasing))
    lineJoin = NSExpression(forConstantValue: "round")

    if isCasing {
      lineGapWidth = NSExpression(format: widthFormat, stops(false))
    }

    guard let dashPattern = decorator.dashPattern  else {
      lineCap = NSExpression(forConstantValue: "round")
      return
    }

    linePattern = nil
    lineDashPattern = NSExpression(forConstantValue: dashPattern)
  }

  private func stops(_ isCasing: Bool) -> [Double: Double] {
    let highwayType = decorator.highwayType
    let casingWidthMultiplier = { isCasing ? 0.1 : 1 }()

    return [
        0: 0,
        5: HighwayTypeProperty(type: highwayType).width(at: 5) * casingWidthMultiplier,
        12: HighwayTypeProperty(type: highwayType).width(at: 12) * casingWidthMultiplier,
        18: HighwayTypeProperty(type: highwayType).width(at: 18) * casingWidthMultiplier,
      ]
    }

  init(_ identifier: String, on style: MGLStyle, with streets: [StreetFilterable]) {
    let shapes = StreetLayer.polylines(from: streets as! [OSMWay])
    let source = MGLShapeSource(identifier: "line-\(identifier)", shapes: shapes, options: nil)
    style.addSource(source)

    super.init(identifier: "line-layer-\(identifier)", source: source)
  }
}

extension StreetLayer {
  static func polylines(from osmWays: [OSMWay]) -> [MGLPolyline] {
    return osmWays.map { way in
      let coordinates = way.coordinates
      let count = UInt(coordinates.count)
      return MGLPolyline(coordinates: coordinates, count: count)
    }
  }
}
