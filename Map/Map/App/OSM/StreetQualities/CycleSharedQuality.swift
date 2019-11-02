//
//  CycleSharedQuality.swift
//  Map
//
//  Created by Benjamin Lewis on 29/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class CycleSharedQuality: StreetQualitatable {
  var casingColor: UIColor? = #colorLiteral(red: 0.7411025167, green: 0.7412283421, blue: 0.7410858274, alpha: 1)
  var color: UIColor = #colorLiteral(red: 0.9410838485, green: 0.9412414432, blue: 0.9410631061, alpha: 1)
  var dashPattern: [Double]?
  var highwayType: HighwayType = .street

  func filter(_ streets: [StreetFilterable]) -> [StreetFilterable] {
    return streets.filter { street in
      return [.residential, .livingStreet, .street].contains(street.highway) &&
        ![.cobblestone].contains(street.surface) &&
        [.excellent, .good, .unknown].contains(street.smoothness)
    }
  }
}
