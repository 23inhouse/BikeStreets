//
//  SurfaceType.swift
//  Map
//
//  Created by Benjamin Lewis on 26/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Foundation

enum SurfaceType: String {
  case asphalt
  case cobblestone
  case concrete
  case paved
  case pavingStones
  case sett
  case unknown

  static func make(from value: String?) -> SurfaceType {
    return SurfaceType(rawValue: value ?? "") ?? .unknown
  }
}
