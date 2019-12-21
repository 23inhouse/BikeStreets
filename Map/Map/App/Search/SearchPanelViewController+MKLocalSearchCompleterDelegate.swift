//
//  SearchPanelViewController+MKLocalSearchCompleterDelegate.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import MapKit

extension SearchPanelViewController: MKLocalSearchCompleterDelegate {
  func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
    searchResultNavigationVC.searchResultsVC.searchResults = completer.results

    let searchResultsVC = searchResultNavigationVC.searchResultsVC
    searchResultNavigationVC.pushOrPopToViewController(searchResultsVC, animated: true)
  }

  func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
    print("Error: Can't complete the search")
    print(error)
  }
}
