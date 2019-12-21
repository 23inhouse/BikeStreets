//
//  CobblestoneQuality.swift
//  Map
//
//  Created by Benjamin Lewis on 31/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class CobblestoneQuality: StreetQualitatable {
  var casingColor: UIColor? = #colorLiteral(red: 0.8000243902, green: 0.8001326919, blue: 0.7913011312, alpha: 1)
  var color: UIColor = #colorLiteral(red: 0.9459878802, green: 0.9533813596, blue: 0.9054790139, alpha: 1)
  var dashPattern: [Double]? = [0.3, 0.3]
  var highwayType: HighwayType = .residential

  func filter(_ streets: [StreetFilterable]) -> [StreetFilterable] {
    return streets.filter { street in
      return street.surface != .asphalt &&
        !street.bicycle && street.highway != .cycleway &&
        (
          street.surface == .cobblestone ||
            ![.excellent, .good, .unknown].contains(street.smoothness)
      )
    }
  }
}
