//
//  CyclewayType.swift
//  Map
//
//  Created by Benjamin Lewis on 26/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Foundation

enum CyclewayType: String {
  case cyclestreet
  case lane, opposite_lane
  case opposite
  case path, ramp, street, shared
  case track, opposite_track
  case prohibited
  case unknown

  static func make(from value: String?) -> CyclewayType {
    return CyclewayType(rawValue: value ?? "") ?? .unknown
  }
}
