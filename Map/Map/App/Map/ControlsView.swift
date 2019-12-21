//
//  ControlsView.swift
//  Map
//
//  Created by Benjamin Lewis on 10/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class ControlsView: UIView {
  let infoButton: UIButton = {
    let infoButton = UIButton()
    infoButton.layer.cornerRadius = 9
    infoButton.layer.masksToBounds = true
    infoButton.layer.borderColor = UIColor.lightGray.cgColor
    infoButton.layer.borderWidth = 1
    infoButton.imageEdgeInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
    infoButton.setImage(UIImage(named: "info-icon"), for: .normal)
    infoButton.backgroundColor = .white
    return infoButton
  }()

  let locationButton: UIButton = {
    let locationButton = UIButton()
    locationButton.layer.cornerRadius = 9
    locationButton.layer.masksToBounds = true
    locationButton.layer.borderColor = UIColor.lightGray.cgColor
    locationButton.layer.borderWidth = 1
    locationButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    locationButton.setImage(UIImage(named: "location-icon"), for: .normal)
    locationButton.backgroundColor = .white
    return locationButton
  }()

  override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
    for subview in subviews as [UIView] {
      if !subview.isHidden && subview.alpha > 0 && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
        return true
      }
    }
    return false
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupView()
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension ControlsView {
  func setupConstraints() {
    infoButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      infoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -9),
      infoButton.topAnchor.constraint(equalTo: topAnchor, constant: 30),
      infoButton.widthAnchor.constraint(equalToConstant: 38.0),
      infoButton.heightAnchor.constraint(equalToConstant: 38.0)
      ])

    locationButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      locationButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -9),
      locationButton.topAnchor.constraint(equalTo: topAnchor, constant: 70),
      locationButton.widthAnchor.constraint(equalToConstant: 38.0),
      locationButton.heightAnchor.constraint(equalToConstant: 38.0)
      ])
  }

  func setupView() {
    addSubview(infoButton)
    addSubview(locationButton)
  }
}
