//
//  CycleLaneQuality.swift
//  Map
//
//  Created by Benjamin Lewis on 29/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class CycleLaneQuality: StreetQualitatable {
  var casingColor: UIColor? = #colorLiteral(red: 0.8340142965, green: 0.7820234895, blue: 0.6137346625, alpha: 1)
  var color: UIColor = #colorLiteral(red: 0.9758881927, green: 0.9312458634, blue: 0.7322738171, alpha: 1)
  var dashPattern: [Double]?
  var highwayType: HighwayType = .secondary

  func filter(_ streets: [StreetFilterable]) -> [StreetFilterable] {
    return streets.filter { street in
      return [.livingStreet, .motorway, .primary, .residential, .secondary, .street, .tertiary].contains(street.highway) &&
      [.lane, .opposite_lane].contains(street.cycleway) && !street.surfaceColor &&
      ![.cobblestone].contains(street.surface)
    }
  }
}
