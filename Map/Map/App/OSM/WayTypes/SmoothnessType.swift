//
//  SmoothnessType.swift
//  Map
//
//  Created by Benjamin Lewis on 26/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Foundation

enum SmoothnessType: String {
  case excellent, good,
  intermediate,
  bad, veryBad = "very_bad",
  horrible, veryHorrible = "very_horrible",
  impassable,
  unknown

  static func make(from value: String?) -> SmoothnessType {
    return SmoothnessType(rawValue: value ?? "") ?? .unknown
  }
}
