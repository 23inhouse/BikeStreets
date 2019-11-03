//
//  ControlsView.swift
//  Map
//
//  Created by Benjamin Lewis on 10/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class ControlsView: UIView {
  let centerButton: UIButton = {
    let centerButton = UIButton()
    centerButton.layer.cornerRadius = 9
    centerButton.layer.masksToBounds = true
    centerButton.setTitle("♐︎", for: .normal)
    centerButton.backgroundColor = #colorLiteral(red: 0.5322307642, green: 0.1255653895, blue: 0.5086023617, alpha: 1)
    return centerButton
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
    centerButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      centerButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -9),
      centerButton.topAnchor.constraint(equalTo: topAnchor, constant: 70),
      centerButton.widthAnchor.constraint(equalToConstant: 38.0),
      centerButton.heightAnchor.constraint(equalToConstant: 38.0)
      ])
  }

  func setupView() {
    addSubview(centerButton)
  }
}
