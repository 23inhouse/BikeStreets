//
//  HighwayTypeWidth.swift
//  Map
//
//  Created by Benjamin Lewis on 25/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Foundation

struct HighwayTypeProperty {
  var type: HighwayType

  func width(at zoomLevel: Double) -> Double {
    switch zoomLevel {
    case 18...:
      return zoom18Width()
    case 12..<18:
      return zoom12Width()
    case 5..<12:
      return zoom5Width()
    default:
      return 0
    }
  }
}

private extension HighwayTypeProperty {
  func zoom18Width() -> Double {
    switch type {
    case .motorway, .primary:
      return 32
    case .secondary, .tertiary:
      return 24
    case .street:
      return 12
    case .residential:
      return 10
    default:
      return 1
    }
  }

  func zoom12Width() -> Double {
    switch type {
    case .motorway, .primary:
      return 4
    case .secondary:
      return 2
    case .tertiary:
      return 1.5
    case .street:
      return 1
    default:
      return 0
    }
  }

  func zoom5Width() -> Double {
    switch type {
    case .motorway, .primary:
      return 0.5
    case .secondary:
      return 0.01
    default:
      return 0
    }
  }
}
