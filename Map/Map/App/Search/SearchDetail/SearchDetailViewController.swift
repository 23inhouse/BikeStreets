//
//  SearchDetailViewController.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import CoreLocation
import Contacts
import Mapbox
import MapKit
import UIKit

class SearchDetailViewController: UIViewController {
  weak var coordinator: AppCoordinator?

  let searchDetailView = SearchDetailView()

  var annotations: [MGLPointAnnotation]?
  var mapView: MGLMapView?

  var mapItem: MKMapItem?

  @objc func touchCallNumber(_ sender: UIButton) {
    presentCallNumber()
  }

  @objc func touchOpenBrowser(_ sender: UIButton) {
    presentWebsite()
  }

  @objc func touchRouteTo(_ sender: UIButton) {
    guard let annotations = annotations else { return }
    guard annotations.count == 1 else { return }
    let annotation = annotations.first!
    coordinator?.route(to: annotation.coordinate)
  }

  @objc func touchSetHome(_ sender: UIButton) {
    focusAnnotation()
    storeHomeData()
  }

  @objc func touchShare(_ sender: UIButton) {
    presentItemToShare()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    annotate()
    drawView()
    focusAnnotation()
    coordinator?.show(panel: .search, position: .half)
  }
}

private extension SearchDetailViewController {
  func focusAnnotation() {
    guard let annotations = annotations else { return }
    guard annotations.count == 1 else { return }
    let annotation = annotations.first!
    coordinator?.go(to: annotation.coordinate)
  }

  func drawView() {
    guard let mapItem = mapItem else { return }

    searchDetailView.name.text = mapItem.name
    searchDetailView.name.isHidden = isAddressOnly(mapItem: mapItem)
    searchDetailView.address.text = mapItem.postalAddress()
    searchDetailView.phone.text = mapItem.phoneNumber
    searchDetailView.url.text = mapItem.url?.absoluteString
    searchDetailView.openBrowserButton.isHidden = searchDetailView.url.text == nil
    searchDetailView.callButton.isHidden = searchDetailView.phone.text == nil
  }

  func isAddressOnly(mapItem: MKMapItem) -> Bool {
    guard let name = mapItem.name else { return true }
    guard let address = mapItem.postalAddress() else { return false }
    return address.contains(name)
  }

  func presentCallNumber() {
    let application = UIApplication.shared

    guard let phoneNumber = searchDetailView.phone.text else { return }
    guard let regex = try? NSRegularExpression(pattern: "[^\\d\\+#]", options: .caseInsensitive) else { return }
    let validNumber = regex.stringByReplacingMatches(in: phoneNumber, options: [], range: NSRange(location: 0, length: phoneNumber.count), withTemplate: "")
    guard let phoneCallURL = URL(string: "tel://\(validNumber)") else { return }
    guard application.canOpenURL(phoneCallURL) else { return }

    application.open(phoneCallURL)
  }

  func presentItemToShare() {
    let item = [
      searchDetailView.name.text,
      searchDetailView.address.text,
      searchDetailView.phone.text,
      searchDetailView.url.text,
      ].map { return $0 ?? "" }.joined(separator: "\n")

    let activityItems = [item]
    let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    self.present(activityViewController, animated: true, completion: nil)
  }

  func presentWebsite() {
    guard let urlString = searchDetailView.url.text else { return }
    guard let url = URL(string: urlString) else { return }
    UIApplication.shared.open(url)
  }

  func setupView() {
    view.addSubview(searchDetailView)
    searchDetailView.constrain(to: view)

    searchDetailView.callButton.addTarget(self, action: #selector(touchCallNumber), for: .touchUpInside)
    searchDetailView.openBrowserButton.addTarget(self, action: #selector(touchOpenBrowser), for: .touchUpInside)
    searchDetailView.locationButton.addTarget(self, action: #selector(touchSetHome), for: .touchUpInside)
    searchDetailView.setHomeButton.addTarget(self, action: #selector(touchSetHome), for: .touchUpInside)
    searchDetailView.shareButton.addTarget(self, action: #selector(touchShare), for: .touchUpInside)
    searchDetailView.directionButton.addTarget(self, action: #selector(touchRouteTo), for: .touchUpInside)
  }

  func storeHomeData() {
    guard let annotations = annotations else { return }
    guard annotations.count == 1 else { return }
    let annotation = annotations.first!
    UserData.storeLatitude(annotation.coordinate.latitude)
    UserData.storeLongitude(annotation.coordinate.longitude)
  }
}
