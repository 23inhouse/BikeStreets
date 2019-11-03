//
//  ControlsViewController.swift
//  Map
//
//  Created by Benjamin Lewis on 10/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class ControlsViewController: UIViewController {
  weak var mapDelegate: MapViewController?

  lazy private var mainView: ControlsView = { return self.view as! ControlsView }()

  @objc func touchCenter(_ sender: UIButton) {
    mapDelegate?.setCenterToCurrent()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()
  }
}

private extension ControlsViewController {
  func setupView() {
    self.view = ControlsView()

    mainView.centerButton.addTarget(self, action: #selector(touchCenter), for: .touchUpInside)
  }
}
