//
//  ControlsViewController.swift
//  Map
//
//  Created by Benjamin Lewis on 10/10/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class ControlsViewController: UIViewController {
  weak var coordinator: AppCoordinator?
  weak var mapDelegate: MapViewController?

  lazy private var mainView: ControlsView = { return self.view as! ControlsView }()

  @objc func touchInfo(_ sender: UIButton) {
    coordinator?.show(panel: .info)
  }

  @objc func touchLocation(_ sender: UIButton) {
    mapDelegate?.setLocationToCurrent()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()
  }
}

private extension ControlsViewController {
  func setupView() {
    self.view = ControlsView()

    mainView.infoButton.addTarget(self, action: #selector(touchInfo), for: .touchUpInside)
    mainView.locationButton.addTarget(self, action: #selector(touchLocation), for: .touchUpInside)
  }
}
