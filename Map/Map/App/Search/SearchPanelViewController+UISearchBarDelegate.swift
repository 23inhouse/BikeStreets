//
//  SearchPanelViewController+UISearchBarDelegate.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import MapKit
import UIKit

extension SearchPanelViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    guard searchText.count > 0 else {
      searchResultNavigationVC.popToRootViewController(animated: true)
      return
    }
    searchCompleter.queryFragment = searchText
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = false
    searchBar.resignFirstResponder()
    coordinator?.show(panel: .search, position: .tip)
  }

  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = true
    coordinator?.show(panel: .search, position: .full)
  }
}
