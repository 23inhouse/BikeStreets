//
//  SearchResultsViewController+UITableViewDelegate.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Mapbox
import MapKit
import UIKit

extension SearchResultsViewController: UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    coordinator?.searchBar?.resignFirstResponder()
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let completion = searchResults[indexPath.row]

    coordinator?.searchBar?.resignFirstResponder()

    guard let navVC = navigationController as? SearchResultNavigationController else { return }

    if completion.subtitle == "Search Nearby" {
      navVC.searchNearbyVC.search(for: completion) {
        navVC.pushOrPopToViewController(navVC.searchNearbyVC, animated: true)
      }
      return
    }

    search(for: completion) { [weak self] response in
      guard let mapItem = response.mapItems.first else { return }

      let searchDetailVC = navVC.searchDetailVC

      searchDetailVC.annotations = self?.makeAnnotations(from: response.mapItems)
      searchDetailVC.mapItem = mapItem
      navVC.pushOrPopToViewController(searchDetailVC, animated: true)
      UserData.storeSearch(mapItem: mapItem)
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 75
  }
}
