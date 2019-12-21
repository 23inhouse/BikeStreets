//
//  SearchResultNavigationController.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class SearchResultNavigationController: UINavigationController {
  weak var coordinator: AppCoordinator?

  let transition: CATransition = {
    let transition = CATransition()
    transition.duration = 0.5
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    transition.type = CATransitionType.fade
    return transition
  }()

  private(set) lazy var recentResultsVC: RecentResultsViewController = {
    let recentResultsVC = RecentResultsViewController()
    recentResultsVC.coordinator = coordinator
    recentResultsVC.mapView = coordinator?.mapView
    return recentResultsVC
  }()

  private(set) lazy var searchDetailVC: SearchDetailViewController = {
    let searchDetailVC = SearchDetailViewController()
    searchDetailVC.coordinator = coordinator
    searchDetailVC.mapView = coordinator?.mapView
    return searchDetailVC
  }()

  private(set) lazy var searchNearbyVC: SearchNearbyViewController = {
    let searchNearbyVC = SearchNearbyViewController()
    searchNearbyVC.coordinator = coordinator
    searchNearbyVC.mapView = coordinator?.mapView
    return searchNearbyVC
  }()

  private(set) lazy var searchResultsVC: SearchResultsViewController = {
    let searchResultsVC = SearchResultsViewController()
    searchResultsVC.coordinator = coordinator
    searchResultsVC.mapView = coordinator?.mapView
    return searchResultsVC
  }()

  func pushOrPopToViewController(_ viewController: UIViewController, animated: Bool) {
    guard topViewController != viewController else { return }

    if viewControllers.contains(viewController) {
      popToViewController(viewController, animated: true)
    } else {
      pushViewController(viewController, animated: true)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
}

private extension SearchResultNavigationController {
  func setupView() {
    navigationBar.isHidden = true
    pushViewController(recentResultsVC, animated: false)
  }
}
