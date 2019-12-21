//
//  API.swift
//  Map
//
//  Created by Benjamin Lewis on 23/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Foundation
import Mapbox

struct API {
  static func fetchWays(for resources: [String], completion: @escaping (String, [OSMWay]) -> Void) {
    for resource in resources {
      fetchWays(for: resource, completion: completion)
    }
  }

  static func fetchWays(for resource: String, completion: @escaping (String, [OSMWay]) -> Void) {
    guard let jsonPath = Bundle.main.path(forResource: resource, ofType: "json") else {
      print("ERROR: could find \(resource)")
      return
    }

    let url = URL(fileURLWithPath: jsonPath)

    do {
      let data = try Data(contentsOf: url)
      let osmRawData = OSMRawData.decode(from: data)

      guard let osmWays = OSMDataBridge(osmRawData: osmRawData).make() else { return }

      completion(resource, osmWays)
    } catch {
      print("Error:", error.localizedDescription)
    }
  }
}
