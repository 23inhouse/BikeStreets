//
//  OSMRawData.swift
//  Map
//
//  Created by Benjamin Lewis on 22/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Foundation

struct OSMRawData: Codable {
  var elements: [OSMRawElement]

  private enum CodingKeys: String, CodingKey {
    case elements
  }
}

struct OSMRawElement: Codable {
  var id: UInt
  var geometry: [OSMRawGeometry]?
  var tags: OSMRawTags?
  var type: String?
}

struct OSMRawGeometry: Codable {
  var lat: Double
  var lon: Double
}

struct OSMRawTags: Codable {
  var bicycle: String?
  var bicycleRoad: String?
  var cycleStreet: String?
  var cycleway: String?
  var cyclewayBicycle: String?
  var cyclewayBoth: String?
  var cyclewayLeft: String?
  var cyclewayLeftSurface: String?
  var cyclewayLeftSurfaceColor: String?
  var cyclewayRight: String?
  var cyclewayRightSurface: String?
  var cyclewayRightSurfaceColor: String?
  var cyclewaySurface: String?
  var cyclewaySurfaceColor: String?
  var highway: String?
  var name: String?
  var rampBicycle: String?
  var smoothness: String?
  var surface: String?

  private enum CodingKeys: String, CodingKey {
    case bicycle = "bicycle"
    case bicycleRoad = "bicycle_road"
    case cycleStreet = "cyclestreet"
    case cycleway = "cycleway"
    case cyclewayBicycle = "cycleway:bicycle"
    case cyclewayBoth = "cycleway:both"
    case cyclewayLeft = "cycleway:left"
    case cyclewayLeftSurface = "cycleway:left:surface"
    case cyclewayLeftSurfaceColor = "cycleway:left:surface:colour"
    case cyclewayRight = "cycleway:right"
    case cyclewayRightSurface = "cycleway:right:surface"
    case cyclewayRightSurfaceColor = "cycleway:right:surface:colour"
    case cyclewaySurface = "cycleway:surface"
    case cyclewaySurfaceColor = "cycleway:surface:colour"
    case highway = "highway"
    case name = "name"
    case rampBicycle = "ramp:bicycle"
    case smoothness = "smoothness"
    case surface = "surface"
  }
}

extension OSMRawData {
  static func decode(from json: Data) -> OSMRawData? {
    do {
      return try JSONDecoder().decode(OSMRawData.self, from: json)
    } catch {
      print("""
      Error: Couldn't decode the JSON string
      \(error.localizedDescription)
      """)
    }

    return nil
  }
}
