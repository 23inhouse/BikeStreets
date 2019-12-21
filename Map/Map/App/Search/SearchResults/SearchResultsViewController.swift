//
//  SearchResultsViewController.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Mapbox
import MapKit
import UIKit

class SearchResultsViewController: UIViewController {
  weak var coordinator: AppCoordinator?

  let cellIdentifier = "SearchResultViewCell"

  var searchResultsTV = UITableView()
  var searchResults = [MKLocalSearchCompletion]() {
    didSet {
      searchResultsTV.reloadData()
    }
  }

  var annotations: [MGLPointAnnotation]?
  var mapView: MGLMapView?

  func search(for completion: MKLocalSearchCompletion, completionHandler: @escaping (MKLocalSearch.Response) -> Void) {
    let searchRequest = MKLocalSearch.Request(completion: completion)
    let search = MKLocalSearch(request: searchRequest)

    search.start { (response, _) in
      guard let response = response else { return }
      completionHandler(response)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    annotate()
    coordinator?.track(scrollView: searchResultsTV)
  }
}

private extension SearchResultsViewController {
  func setupView() {
    view.addSubview(searchResultsTV)
    searchResultsTV.constrain(to: view)
    view.backgroundColor = .red

    searchResultsTV.delegate = self
    searchResultsTV.dataSource = self
    searchResultsTV.register(SearchResultViewCell.self, forCellReuseIdentifier: cellIdentifier)
  }
}
