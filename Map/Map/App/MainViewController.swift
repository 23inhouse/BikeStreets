//
//  MainViewController.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import FloatingPanel
import Mapbox
import MapKit
import UIKit

class MainViewController: UIViewController {
  weak var coordinator: AppCoordinator?

  enum Panel {
    case info, search
  }

  private(set) lazy var floatingInfoVC: FloatingPanelController = {
    let floatingInfoVC = FloatingPanelController()
    floatingInfoVC.delegate = infoPanelVC
    return floatingInfoVC
  }()

  private(set) lazy var floatingSearchVC: FloatingPanelController = {
    let floatingSearchVC = FloatingPanelController()
    floatingSearchVC.delegate = searchPanelVC
    return floatingSearchVC
  }()

  private(set) lazy var infoPanelVC: InfoPanelViewController = {
    let infoPanelVC = InfoPanelViewController()
    infoPanelVC.coordinator = coordinator
    return infoPanelVC
  }()

  private(set) lazy var mapVC: MapViewController = {
    let mapVC = MapViewController()
    mapVC.coordinator = coordinator
    return mapVC
  }()

  private(set) lazy var searchPanelVC: SearchPanelViewController = {
    let searchPanelVC = SearchPanelViewController()
    searchPanelVC.coordinator = coordinator
    return searchPanelVC
  }()

  func show(panel: Panel, position: FloatingPanelPosition? = nil, annotation: MGLAnnotation? = nil) {
    switch panel {
    case .info:
      floatingInfoVC.move(to: position ?? .full, animated: true)
      floatingSearchVC.move(to: .hidden, animated: true)
    case .search:
      floatingSearchVC.move(to: position ?? .tip, animated: true)
      floatingInfoVC.move(to: .hidden, animated: true)

      //      guard let annotation = annotation else { return }
      //      guard let delegate = floatingSearchVC.delegate as? SearchPanelViewController else { return }
      //      let navVC = delegate.searchResultNavigationVC
      //
      //      guard navVC.viewControllers.last != navVC.searchDetailVC else { return }
      //
      //      if navVC.viewControllers.last == navVC.searchResultsVC {
      //        for (i, res) in navVC.searchResultsVC.searchResults.enumerated() where res.title == annotation.title {
      //          navVC.searchResultsVC.searchResultsTV.selectRow(at: IndexPath(item: i, section: 1), animated: false, scrollPosition: .none)
      //        }
      //      }
      //
      //      if navVC.viewControllers.last == navVC.searchNearbyVC {
      //        for (i, res) in navVC.searchNearbyVC.searchNearbyResults.enumerated() where res.name == annotation.title {
      //          navVC.searchNearbyVC.searchNearbyResultsTV.selectRow(at: IndexPath(item: i, section: 1), animated: false, scrollPosition: .none)
      //        }
      //      }
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setupApperance()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
}

private extension MainViewController {
  func setupApperance() {
    floatingInfoVC.move(to: .hidden, animated: false)
    floatingSearchVC.move(to: .tip, animated: false)
  }

  func setupStatusBar() {
    let statusBarWindow = UIApplication.shared.value(forKey: "statusBarWindow") as? UIView
    guard let statusBar = statusBarWindow?.subviews.first else { return }
    let backgroundColor = UIColor(red: 213 / 255.0, green: 213 / 255.0, blue: 213 / 255.0, alpha: 0.3)
    statusBar.backgroundColor = backgroundColor
  }

  func setupView() {
    setupStatusBar()

    add(mapVC)
    view.addSubview(mapVC.view)
    mapVC.view.constrain(to: view)

    floatingSearchVC.set(contentViewController: searchPanelVC)
    floatingSearchVC.addPanel(toParent: self)

    floatingInfoVC.set(contentViewController: infoPanelVC)
    floatingInfoVC.addPanel(toParent: self)
  }
}
