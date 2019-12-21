//
//  SearchDetailView.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class SearchDetailView: UIView {
  let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 10
    return stackView
  }()

  let buttonStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 10
    return stackView
  }()

  let shareButton = UIButton.Icon(named: "square.arrow.up", edgeInset: 6)
  let directionButton = UIButton.Icon(named: "up.arrow.right.diamond", edgeInset: 6)
  let callButton = UIButton.Icon(named: "phone", edgeInset: 6)
  let openBrowserButton = UIButton.Icon(named: "eyeglasses", edgeInset: 6)
  let buttonSpacer = UIButton()

  let name = UILabel()
  let address: UILabel = {
    let address = UILabel()
    address.numberOfLines = 3
    return address
  }()
  let phone = UILabel()
  let url = UILabel()

  let homeStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.spacing = 10
    return stackView
  }()
  let locationButton = UIButton.Icon(named: "location", edgeInset: 6)
  let setHomeButton: UIButton = {
    let setHomeButton = UIButton()
    setHomeButton.setTitle("Set as home", for: .normal)
    setHomeButton.setTitleColor(.black, for: .normal)
    setHomeButton.contentHorizontalAlignment = .left
    setHomeButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    return setHomeButton
  }()
  let homeSpacer = UIButton()

  let contentSpacer = UITextView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupView()
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension SearchDetailView {
  func setupConstraints() {
    stackView.constrain(to: self, margin: 10)
    for button in [openBrowserButton, callButton, locationButton, directionButton, shareButton] {
      button.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        button.heightAnchor.constraint(equalToConstant: 38),
        button.widthAnchor.constraint(equalTo: button.heightAnchor),
        ])
    }
    contentSpacer.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    buttonSpacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    homeSpacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
  }

  func setupView() {
    backgroundColor = .white
    addSubview(stackView)

    stackView.addArrangedSubview(buttonStackView)
    buttonStackView.addArrangedSubview(buttonSpacer)
    buttonStackView.addArrangedSubview(openBrowserButton)
    buttonStackView.addArrangedSubview(callButton)
    buttonStackView.addArrangedSubview(directionButton)
    buttonStackView.addArrangedSubview(shareButton)

    stackView.addArrangedSubview(name)
    stackView.addArrangedSubview(address)
    stackView.addArrangedSubview(phone)
    stackView.addArrangedSubview(url)

    stackView.addArrangedSubview(homeStackView)
    homeStackView.addArrangedSubview(locationButton)
    homeStackView.addArrangedSubview(setHomeButton)
    homeStackView.addArrangedSubview(homeSpacer)

    stackView.addArrangedSubview(contentSpacer)
  }
}
