//
//  RecentResultsViewController+UITableViewDelegate.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

extension RecentResultsViewController: UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    coordinator?.searchBar?.resignFirstResponder()
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    guard let navVC = navigationController as? SearchResultNavigationController else { return }

    let mapItem = recentResults[indexPath.row]
    let searchDetailVC = navVC.searchDetailVC
    searchDetailVC.annotations = makeAnnotations(from: [mapItem])
    searchDetailVC.mapItem = mapItem
    navVC.pushOrPopToViewController(searchDetailVC, animated: true)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 75
  }

}
