//
//  HighwayType.swift
//  Map
//
//  Created by Benjamin Lewis on 25/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Foundation

enum HighwayType: String {
  case cycleway
  case footway
  case livingStreet = "living_street"
  case motorway
  case motorwayLink = "motorway_link"
  case path
  case pedestrian
  case primary
  case residential
  case secondary
  case street
  case streetLimited = "street_limited"
  case tertiary
  case trunk
  case trunkLink = "trunk_link"
  case unknown

  static func make(from value: String?) -> HighwayType {
    return HighwayType(rawValue: value ?? "") ?? .unknown
  }
}
