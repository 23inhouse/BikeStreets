//
//  UIViewController+Subcontroller.swift
//  Map
//
//  Created by Benjamin Lewis on 9/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

@nonobjc extension UIViewController {
  func add(_ child: UIViewController, frame: CGRect? = nil) {
    addChild(child)

    if let frame = frame {
      child.view.frame = frame
    }

    view.addSubview(child.view)
    child.didMove(toParent: self)
  }

  func add(_ child: UIViewController, to subview: UIView) {
    addChild(child)
    subview.addSubview(child.view)
    child.didMove(toParent: self)
    child.view.constrain(to: subview)
  }

  func remove() {
    willMove(toParent: nil)
    view.removeFromSuperview()
    removeFromParent()
  }
}
