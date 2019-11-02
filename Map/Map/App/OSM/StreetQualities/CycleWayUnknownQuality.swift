//
//  CycleWayUnknownQuality.swift
//  Map
//
//  Created by Benjamin Lewis on 1/11/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class CycleWayUnknownQuality: StreetQualitatable {
  var casingColor: UIColor? = #colorLiteral(red: 0.5509549379, green: 0.4133927524, blue: 0.3178817034, alpha: 1)
  var color: UIColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
  var dashPattern: [Double]?
  var highwayType: HighwayType = .tertiary

  func filter(_ streets: [StreetFilterable]) -> [StreetFilterable] {
    return streets.filter { street in
      return street.highway == .cycleway && (street.surface == .unknown && street.smoothness == .unknown)
    }
  }
}
