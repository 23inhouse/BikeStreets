//
//  SearchPanelView.swift
//  Map
//
//  Created by Benjamin Lewis on 21/12/19.
//  Copyright © 2019 Benjamin Lewis. All rights reserved.
//

import UIKit

class SearchPanelView: UIView {
  private(set) var searchBarView = UIView()
  private(set) var searchResultsView = UIView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupView()
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

private extension SearchPanelView {
  func setupConstraints() {
    searchBarView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      searchBarView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
      searchBarView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
      searchBarView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
      searchBarView.heightAnchor.constraint(equalToConstant: 60.0)
      ])

    searchResultsView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      searchResultsView.topAnchor.constraint(equalTo: topAnchor, constant: 70),
      searchResultsView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
      searchResultsView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
      searchResultsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
      ])
  }

  func setupView() {
    addSubview(searchBarView)
    addSubview(searchResultsView)
  }
}
