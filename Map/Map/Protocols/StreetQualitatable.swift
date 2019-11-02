//
//  StreetQualitatable.swift
//  Map
//
//  Created by Benjamin Lewis on 29/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

protocol StreetQualitatable {
  var casingColor: UIColor? { get }
  var color: UIColor { get }
  var dashPattern: [Double]? { get }
  var highwayType: HighwayType { get }

  func filter(_ streets: [StreetFilterable]) -> [StreetFilterable]
}

extension StreetQualitatable {
//  func draw() {
//    let style = StreetLayer(for: streetQuality, on: style, with: ways)
//
//  }
}
