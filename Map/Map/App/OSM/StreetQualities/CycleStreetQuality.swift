//
//  StreetQuality.swift
//  Map
//
//  Created by Benjamin Lewis on 29/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class CycleStreetQuality: StreetQualitatable {
  var casingColor: UIColor? = #colorLiteral(red: 0.5336527824, green: 0.3622873425, blue: 0.3237170577, alpha: 1)
  var color: UIColor = #colorLiteral(red: 0.8819727302, green: 0.6025319099, blue: 0.5308958888, alpha: 1)
  var dashPattern: [Double]?
  var highwayType: HighwayType = .secondary

  func filter(_ streets: [StreetFilterable]) -> [StreetFilterable] {
    return streets.filter { street in
      return [.cyclestreet, .street].contains(street.cycleway)
    }
  }
}
