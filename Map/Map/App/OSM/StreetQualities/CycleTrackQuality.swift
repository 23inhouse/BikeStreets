//
//  CycleTrackQuality.swift
//  Map
//
//  Created by Benjamin Lewis on 29/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class CycleTrackQuality: StreetQualitatable {
  var casingColor: UIColor? = #colorLiteral(red: 0.5925186276, green: 0.5184105039, blue: 0.4822110534, alpha: 1)
  var color: UIColor = #colorLiteral(red: 0.9104626179, green: 0.8289259076, blue: 0.709180057, alpha: 1)
  var dashPattern: [Double]?
  var highwayType: HighwayType = .secondary

  func filter(_ streets: [StreetFilterable]) -> [StreetFilterable] {
    return streets.filter { street in
      return ( street.highway == .cycleway && ([.concrete, .pavingStones].contains(street.surface) || [.intermediate].contains(street.smoothness)) ) ||
        (street.highway != .cycleway && [.track, .path, .opposite_track].contains(street.cycleway))
    }
  }
}
