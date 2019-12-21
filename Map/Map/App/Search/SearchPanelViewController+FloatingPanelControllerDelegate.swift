//
//  SearchPanelViewController+FloatingPanelControllerDelegate.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import FloatingPanel

extension SearchPanelViewController: FloatingPanelControllerDelegate {
  func floatingPanelDidChangePosition(_ vc: FloatingPanelController) {
    if vc.position != .full {
      searchBar.resignFirstResponder()
      searchBar.showsCancelButton = false
    }
  }
}
