//
//  AppCoordinator.swift
//  Map
//
//  Created by Benjamin Lewis on 9/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import CoreLocation
import FloatingPanel
import Mapbox
import MapKit
import UIKit

class AppCoordinator: Coordinator {
  var appViewController: AppViewController
  var previousViewController: UIViewController?
  var mainViewController: MainViewController?

  private(set) var resources = [String: [StreetQuality]]()

  var mapView: MGLMapView? { return mainViewController?.mapVC.mapView }
  var searchBar: UISearchBar? { return mainViewController?.searchPanelVC.searchBar }

  init(appViewController: AppViewController) {
    self.appViewController = appViewController
  }

  func go(to location: CLLocationCoordinate2D) {
    mainViewController?.mapVC.currentLocation = location
  }

  func route(to destination: CLLocationCoordinate2D) {
    print("route")
    guard let mainVC = mainViewController else { return }
    guard let currentLocation = mainVC.mapVC.currentLocation else { return }
    mainVC.mapVC.route(from: currentLocation, to: destination)
  }

  func start() {
    let viewController = MainViewController()
    viewController.coordinator = self
    mainViewController = viewController
    go(to: viewController)
  }

  func track(scrollView: UIScrollView?) {
    mainViewController?.floatingSearchVC.track(scrollView: scrollView)
  }

  func show(panel: MainViewController.Panel, position: FloatingPanelPosition? = nil, annotation: MGLAnnotation? = nil) {
    mainViewController?.show(panel: panel, position: position, annotation: annotation)
  }

  func loadAppData() {
    func handleWay(_ resource: String, osmWays: [OSMWay]) {
      DispatchQueue.global(qos: .background).sync {
        print("Loaded:", resource, "|", "found", osmWays.count, "ways")

        let streetQualities = StreetQuality.make(from: osmWays)
        resources[resource] = streetQualities
      }
    }

    DispatchQueue.global(qos: .background).sync {
      guard var files = try? FileManager.default.contentsOfDirectory(atPath: Bundle.main.bundlePath) else { return }
      files = files.filter { file in file.contains("json") }
      let resources = files.map { file in String(file.split(separator: ".").first ?? "") }
      guard resources.count > 0 else { return }

      print("Found json files:", resources)
      API.fetchWays(for: resources, completion: handleWay)
    }
  }
}

private extension AppCoordinator {
  func go(to viewController: UIViewController) {
    guard let view = viewController.view else { return }

    appViewController.add(viewController)
    appViewController.appView.addSubview(view)
    view.constrain(to: appViewController.appView)

    if let previousViewController = previousViewController {
      previousViewController.remove()
    }
    previousViewController = viewController
  }
}
