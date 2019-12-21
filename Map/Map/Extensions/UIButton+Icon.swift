//
//  UIButton+Icon.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

extension UIButton {
  static func Icon(named: String, edgeInset: CGFloat) -> UIButton {
    let iconButton = UIButton()
    iconButton.layer.cornerRadius = 9
    iconButton.layer.masksToBounds = true
    iconButton.layer.borderColor = UIColor.lightGray.cgColor
    iconButton.layer.borderWidth = 1
    iconButton.imageEdgeInsets = UIEdgeInsets(top: edgeInset, left: edgeInset, bottom: edgeInset, right: edgeInset)
    iconButton.setImage(UIImage(named: named), for: .normal)
    iconButton.backgroundColor = .white
    return iconButton
  }
}
