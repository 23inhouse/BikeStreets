//
//  SearchPanelViewController.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import FloatingPanel
import MapKit

class SearchPanelViewController: UIViewController {
  weak var coordinator: AppCoordinator?

  lazy private var searchPanelView = SearchPanelView()

  var searchCompleter = MKLocalSearchCompleter()

  let searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.searchBarStyle = UISearchBar.Style.minimal
    searchBar.placeholder = "Search for a place or address"
    searchBar.sizeToFit()
    searchBar.isTranslucent = false
    return searchBar
  }()

  private(set) lazy var searchResultNavigationVC: SearchResultNavigationController = {
    let searchResultNavigationVC = SearchResultNavigationController()
    searchResultNavigationVC.coordinator = coordinator
    return searchResultNavigationVC
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
}

private extension SearchPanelViewController {
  func setupView() {
    view.addSubview(searchPanelView)
    searchPanelView.constrain(to: view)
    searchPanelView.searchBarView.addSubview(searchBar)

    add(searchResultNavigationVC, to: self.searchPanelView.searchResultsView)

    searchBar.delegate = self
    searchCompleter.delegate = self
  }
}
