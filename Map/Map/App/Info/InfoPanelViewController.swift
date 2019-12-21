//
//  InfoPanelViewController.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class InfoPanelViewController: UIViewController {
  weak var coordinator: AppCoordinator?

  let infoPanelView = InfoPanelView()

  @objc func touchClose(_ sender: UIButton) {
    coordinator?.show(panel: .search)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()
  }
}

private extension InfoPanelViewController {
  func setupView() {
    view.addSubview(infoPanelView)
    infoPanelView.constrain(to: view)

    infoPanelView.closeButton.addTarget(self, action: #selector(touchClose), for: .touchUpInside)
  }
}
