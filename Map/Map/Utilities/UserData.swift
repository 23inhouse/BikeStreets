//
//  UserData.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Foundation
import MapKit

struct UserData {
  enum Key: String {
    case homeLatitude
    case homeLongitude
    case recentSearches
  }

  private static let defaults = UserDefaults.standard

  private static let DefaultLatitude: Double = 52.516
  private static let DefaultLongitude: Double = 13.3885

  static func reset() {
    set(DefaultLatitude, for: .homeLatitude)
    set(DefaultLongitude, for: .homeLongitude)
    remove(for: .recentSearches)
  }

  static func retrieveLatitude() -> Double {
    return double(for: .homeLatitude, default: DefaultLatitude)
  }

  static func retrieveLongitude() -> Double {
    return double(for: .homeLongitude, default: DefaultLongitude)
  }

  static func retrieveSearches() -> [MKMapItem] {
    let searches = unarchiveMapItems(for: .recentSearches)
    return searches ?? []
  }

  static func storeLatitude(_ value: Double) {
    set(value, for: .homeLatitude)
  }

  static func storeLongitude(_ value: Double) {
    set(value, for: .homeLongitude)
  }

  static func storeSearch(mapItem: MKMapItem) {
    var searches = retrieveSearches()
    if let firstIndex = searches.firstIndex(of: mapItem) {
      searches.remove(at: firstIndex)
    }
    searches.append(mapItem)

    set(searches, for: .recentSearches)
  }
}

private extension UserData {
  static func archive(_ mapItems: [MKMapItem]) -> Data? {
    guard let data: Data = try? NSKeyedArchiver.archivedData(withRootObject: mapItems, requiringSecureCoding: false) else { return nil }
    return data
  }

  static func double(for key: Key, default value: Double? = nil) -> Double {
    guard hasValue(for: key) else { return value ?? 0.0 }
    return defaults.double(forKey: key.rawValue)
  }

  static func hasValue(for key: Key) -> Bool {
    return defaults.object(forKey: key.rawValue) != nil
  }

  static func remove(for key: Key) {
    defaults.removeObject(forKey: key.rawValue)
  }

  static func set(_ value: Double, for key: Key) {
    defaults.set(value, forKey: key.rawValue)
  }

  static func set(_ value: [MKMapItem], for key: Key) {
    guard let data = archive(value) else { return }
    defaults.set(data, forKey: key.rawValue)
  }

  static func unarchiveMapItems(for key: Key) -> [MKMapItem]? {
    guard let data = defaults.object(forKey: key.rawValue) as? Data else { return nil }
    guard let mapItems = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [MKMapItem] else { return nil }

    return mapItems
  }
}
