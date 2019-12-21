//
//  InfoPanelViewController+FloatingPanelControllerDelegate.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import FloatingPanel

extension InfoPanelViewController: FloatingPanelControllerDelegate {
  func floatingPanelDidEndDragging(_ vc: FloatingPanelController, withVelocity velocity: CGPoint, targetPosition: FloatingPanelPosition) {
    if targetPosition != .full {
      coordinator?.show(panel: .search)
    }
  }

  func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
    return InfoPanelLayout()
  }
}
