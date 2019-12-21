//
//  SearchResultViewCell.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class SearchResultViewCell: UITableViewCell {

  var desc: UILabel = {
    let desc = UILabel()
    desc.font = UIFont.preferredFont(forTextStyle: .subheadline)
    return desc
  }()

  var name: UILabel = {
    let name = UILabel()
    name.font = UIFont.preferredFont(forTextStyle: .headline)
    return name
  }()

  var picture: UIImageView = UIImageView()

  let hStack: UIStackView = {
    let hStack = UIStackView()
    hStack.axis = .horizontal
    hStack.alignment = .center
    return hStack
  }()

  let vStack: UIStackView = {
    let vStack = UIStackView()
    vStack.axis = .vertical
    return vStack
  }()

  let pictureHolder: UIView = {
    let pictureHolder = UIView()
    return pictureHolder
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    setupView()
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension SearchResultViewCell {
  func setupConstraints() {
    hStack.constrain(to: self)

    pictureHolder.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      pictureHolder.heightAnchor.constraint(equalTo: heightAnchor),
      ])

    picture.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      picture.widthAnchor.constraint(equalTo: picture.heightAnchor),
      ])
    picture.constrain(to: pictureHolder, margins: [20, 10, 20, 10])
  }

  func setupView() {
    addSubview(hStack)
    hStack.addArrangedSubview(pictureHolder)
    hStack.addArrangedSubview(vStack)

    pictureHolder.addSubview(picture)
    vStack.addArrangedSubview(name)
    vStack.addArrangedSubview(desc)
  }
}
