//
//  CobblestoneQuality.swift
//  Map
//
//  Created by Benjamin Lewis on 31/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class CobblestoneQuality: StreetQualitatable {
  var casingColor: UIColor? = #colorLiteral(red: 0.8626597524, green: 0.8628049493, blue: 0.8626406193, alpha: 1)
  var color: UIColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
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
