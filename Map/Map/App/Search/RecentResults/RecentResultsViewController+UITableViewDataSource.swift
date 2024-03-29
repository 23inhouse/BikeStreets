//
//  RecentResultsViewController+UITableViewDataSource.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

extension RecentResultsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recentResults.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let recentResult = recentResults[indexPath.row]

    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SearchResultViewCell
    cell.desc.text = recentResult.postalAddress()
    cell.name.text = recentResult.name
    cell.picture.image = UIImage(named: "LaunchImage")
    return cell
  }
}
