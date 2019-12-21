//
//  SearchNearbyViewController+UITableViewDataSource.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

extension SearchNearbyViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchNearbyResults.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let mapItem = searchNearbyResults[indexPath.row]

    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SearchResultViewCell
    cell.desc.text = mapItem.placemark.title
    cell.name.text = mapItem.placemark.name
    cell.picture.image = UIImage(named: "LaunchImage")
    return cell
  }
}
