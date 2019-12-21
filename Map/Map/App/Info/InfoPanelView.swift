//
//  InfoPanelView.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class InfoPanelView: UIView {
  var closeButton: UIButton = {
    let closeButton = UIButton()
    closeButton.setTitle("Close", for: .normal)
    closeButton.setTitleColor(.blue, for: .normal)
    closeButton.contentHorizontalAlignment = .right
    closeButton.titleEdgeInsets.right = 10
    return closeButton
  }()

  private var infoText: UILabel = {
    let infoText = UILabel()
    infoText.text = "All your info are belong to us!"
    return infoText
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupView()
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension InfoPanelView {
  func setupConstraints() {
    infoText.constrain(to: self, margin: 20)

    closeButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      closeButton.heightAnchor.constraint(equalToConstant: 40.0),
      closeButton.rightAnchor.constraint(equalTo: rightAnchor),
      closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
      closeButton.widthAnchor.constraint(equalToConstant: 80.0),
      ])
  }

  func setupView() {
    addSubview(infoText)
    addSubview(closeButton)
  }
}
