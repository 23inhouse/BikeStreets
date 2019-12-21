//
//  RecentResultsViewController.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Contacts
import Mapbox
import MapKit
import UIKit

class RecentResultsViewController: UIViewController {
  weak var coordinator: AppCoordinator?

  let cellIdentifier = "SearchResultViewCell"

  var recentResultsTV = UITableView()
  var recentResults = [MKMapItem]() {
    didSet {
      recentResultsTV.reloadData()
    }
  }

  var annotations: [MGLPointAnnotation]? = [MGLPointAnnotation]()
  var mapView: MGLMapView?

  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    annotate()
    loadRecentResults()
    coordinator?.track(scrollView: recentResultsTV)
  }
}

private extension RecentResultsViewController {
  func setupView() {
    view.addSubview(recentResultsTV)
    recentResultsTV.constrain(to: view)

    recentResultsTV.delegate = self
    recentResultsTV.dataSource = self
    recentResultsTV.register(SearchResultViewCell.self, forCellReuseIdentifier: cellIdentifier)
  }

  func loadRecentResults() {
    let searches = UserData.retrieveSearches()
    recentResults = searches.reversed()
  }
}
