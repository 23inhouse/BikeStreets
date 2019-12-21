//
//  MKMapItem+Address.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import Contacts
import MapKit

extension MKMapItem {
  func postalAddress() -> String? {
    guard let postalAddress = placemark.postalAddress else { return nil }
    return CNPostalAddressFormatter.string(from: postalAddress, style: .mailingAddress)
  }
}
