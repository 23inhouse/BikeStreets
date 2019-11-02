//
//  CycleUnknownQuality.swift
//  Map
//
//  Created by Benjamin Lewis on 30/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class CycleUnknownQuality: StreetQualitatable {
  var casingColor: UIColor? = #colorLiteral(red: 0.7411025167, green: 0.7412283421, blue: 0.7410858274, alpha: 1)
  var color: UIColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
  var dashPattern: [Double]?
  var highwayType: HighwayType = .motorway

  func filter(_ streets: [StreetFilterable]) -> [StreetFilterable] {
    return streets.filter { street in
      return ([.livingStreet, .residential, .secondary, .street, .tertiary].contains(street.highway) && ![.cobblestone].contains(street.surface)) && (street.surface == .unknown && street.smoothness == .unknown)
    }
  }
}
