//
//  SearchNearbyViewController.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Mapbox
import MapKit
import UIKit

class SearchNearbyViewController: UIViewController {
  weak var coordinator: AppCoordinator?

  let cellIdentifier = "SearchResultViewCell"

  var searchNearbyResultsTV = UITableView()
  var searchNearbyResults = [MKMapItem]() {
    didSet {
      searchNearbyResultsTV.reloadData()
      annotations = makeAnnotations(from: searchNearbyResults)
    }
  }

  var annotations: [MGLPointAnnotation]?
  var mapView: MGLMapView?

  func search(for completion: MKLocalSearchCompletion, completionHandler: @escaping () -> Void) {
    guard let mapView = coordinator?.mapView else { return }

    let searchRequest = MKLocalSearch.Request(completion: completion)
    searchRequest.region = getRegion(mapView: mapView)

    let search = MKLocalSearch(request: searchRequest)

    search.start { [weak self] (response, _) in
      guard let self = self else { return }
      guard let response = response else { return }

      self.searchNearbyResults = response.mapItems

      completionHandler()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    annotate()
    coordinator?.track(scrollView: searchNearbyResultsTV)
  }
}

private extension SearchNearbyViewController {
  func getRegion(mapView: MGLMapView) -> MKCoordinateRegion {
    let center = mapView.centerCoordinate
    let ne = mapView.visibleCoordinateBounds.ne
    let sw = mapView.visibleCoordinateBounds.sw

    let p1 = MKMapPoint(ne)
    let p2 = MKMapPoint(sw)
    let dist: CLLocationDistance = p1.distance(to: p2) / 2
    let region = MKCoordinateRegion(center: center, latitudinalMeters: dist, longitudinalMeters: dist)

    return region
  }

  func setupView() {
    view.addSubview(searchNearbyResultsTV)
    searchNearbyResultsTV.constrain(to: view)

    searchNearbyResultsTV.delegate = self
    searchNearbyResultsTV.dataSource = self
    searchNearbyResultsTV.register(SearchResultViewCell.self, forCellReuseIdentifier: cellIdentifier)
  }
}
