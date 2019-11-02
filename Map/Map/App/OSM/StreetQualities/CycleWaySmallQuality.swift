//
//  CycleWaySmallQuality.swift
//  Map
//
//  Created by Benjamin Lewis on 30/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class CycleWaySmallQuality: StreetQualitatable {
  var casingColor: UIColor? = #colorLiteral(red: 0.5509549379, green: 0.4133927524, blue: 0.3178817034, alpha: 1)
  var color: UIColor = #colorLiteral(red: 0.9676859975, green: 0.7484241128, blue: 0.4698264003, alpha: 1)
  var dashPattern: [Double]?
  var highwayType: HighwayType = .street

  func filter(_ streets: [StreetFilterable]) -> [StreetFilterable] {
    return streets.filter { street in
      return street.bicycle &&
        [.footway, .path, .pedestrian].contains(street.highway) &&
        ([.asphalt, .concrete, .paved].contains(street.surface) || [.excellent, .good].contains(street.smoothness))
    }
  }
}
