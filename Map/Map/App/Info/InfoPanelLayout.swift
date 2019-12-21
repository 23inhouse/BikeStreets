//
//  InfoPanelLayout.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import FloatingPanel

class InfoPanelLayout: FloatingPanelLayout {
  public var initialPosition: FloatingPanelPosition {
    return .full
  }

  var supportedPositions: Set<FloatingPanelPosition> {
    return [.full, .hidden]
  }

  public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
    let inset = FloatingPanelDefaultLayout().insetFor(position: .full)
    switch position {
    case .full: return inset
    case .half: return nil
    case .tip: return nil
    default: return nil
    }
  }
}
