//
//  UIView+Constraints.swift
//  Map
//
//  Created by Benjamin Lewis on 9/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

extension UIView {
  func constrain(to parentView: UIView, margin: CGFloat = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: margin),
      trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -margin),
      topAnchor.constraint(equalTo: parentView.topAnchor, constant: margin),
      bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -margin),
      ])
  }

  func constrain(to parentView: UIView, margins: [CGFloat]) {
    precondition(margins.count == 4)

    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: margins[3]),
      trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -margins[1]),
      topAnchor.constraint(equalTo: parentView.topAnchor, constant: margins[0]),
      bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -margins[2]),
      ])
  }
}
