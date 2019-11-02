//
//  OSMElementToWayBridge.swift
//  Map
//
//  Created by Benjamin Lewis on 23/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import CoreLocation

struct OSMElementToWayBridge {
  let osmRawElement: OSMRawElement

  func make() -> OSMWay? {
    guard osmRawElement.type == "way" else { return nil }
    guard let tags = osmRawElement.tags else { return nil }
    guard let geometry = osmRawElement.geometry else { return nil }

    let id = osmRawElement.id
    let name = tags.name

    let bicycle = bool(from: [tags.bicycle, tags.cyclewayBicycle], trueValues: ["yes", "designated", "use_sidepath"])
    let bicycleRoad = bool(from: tags.bicycleRoad)
    let cycleStreet = bool(from: tags.cycleStreet)
    let cycleway = string(from: [tags.cycleway, tags.cyclewayLeft, tags.cyclewayRight, tags.cyclewayBoth])
    let highway = string(from: tags.highway)
    let smoothness = string(from: tags.smoothness)
    let surface = string(from: [tags.cyclewaySurface, tags.cyclewayLeftSurface, tags.cyclewayRightSurface, tags.surface])
    let surfaceColor = bool(from: [tags.cyclewaySurfaceColor, tags.cyclewayLeftSurfaceColor, tags.cyclewayRightSurfaceColor], trueValues: ["green", "blue", "red", "yellow"])

    let cyclewayType: CyclewayType = {
      if bicycleRoad || cycleStreet {
        return .street
      }
      return CyclewayType.make(from: cycleway)
    }()
    let highwayType = HighwayType.make(from: highway)
    let smoothnessType = SmoothnessType.make(from: smoothness)
    let surfaceType = SurfaceType.make(from: surface)

    let osmWay = OSMWay(id: id, name: name, bicycle: bicycle, cycleway: cyclewayType, highway: highwayType, smoothness: smoothnessType, surface: surfaceType, surfaceColor: surfaceColor)
    osmWay.coordinates = geometry.map { geometry in
      CLLocationCoordinate2D(latitude: geometry.lat, longitude: geometry.lon)
    }

    return osmWay
  }
}

private extension OSMElementToWayBridge {
  func bool(from value: String?, trueValues: [String] = ["yes"]) -> Bool {
    guard let value = value else { return false }
    return trueValues.contains(value)
  }

  func bool(from values: [String?], trueValues: [String] = ["yes"]) -> Bool {
    for value in values {
      if bool(from: value, trueValues: trueValues) {
        return true
      }
    }

    return false
  }

  func string(from value: String?) -> String {
    return value ?? ""
  }

  func string(from values: [String?]) -> String {
    for value in values {
      if let value = value {
        return value
      }
    }

    return ""
  }
}
