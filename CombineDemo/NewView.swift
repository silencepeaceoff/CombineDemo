//
//  View.swift
//  CombineDemo
//
//  Created by Dmitrii Tikhomirov on 5/16/23.
//

import UIKit

final class NewView: UIView {

  var blogTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "New blog post"
    return textField
  }()

  let publishButton: UIButton = {
    let button = UIButton()
    button.setTitle("Publish", for: .normal)
    button.backgroundColor = .blue
    return button
  }()

  private let separator: UIView = {
    let view = UIView()
    view.backgroundColor = .separator
    return view
  }()

  var subscribedLabel: UILabel = {
    let label = UILabel()
    label.text = "Subscriber"
    label.textAlignment = .center
    return label
  }()

  private let horizontalStackView: UIStackView = {
    let view = UIStackView()
    view.axis = .horizontal
    view.alignment = .center
    view.distribution = .fillEqually
    return view
  }()

  private let verticalStackView: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.alignment = .center
    view.distribution = .fillProportionally
    return view
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupView()
    makeConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension NewView {
  func setupView() {
    addSubview(horizontalStackView)
    horizontalStackView.addArrangedSubview(blogTextField)
    horizontalStackView.addArrangedSubview(publishButton)

    addSubview(verticalStackView)
    verticalStackView.addArrangedSubview(horizontalStackView)
    verticalStackView.addArrangedSubview(separator)
    verticalStackView.addArrangedSubview(subscribedLabel)

  }

  func makeConstraints() {
    horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
    verticalStackView.translatesAutoresizingMaskIntoConstraints = false
    separator.translatesAutoresizingMaskIntoConstraints = false
    subscribedLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      horizontalStackView.widthAnchor.constraint(equalToConstant: 300),

      separator.heightAnchor.constraint(equalToConstant: 2),
      separator.widthAnchor.constraint(equalToConstant: 300),

      subscribedLabel.widthAnchor.constraint(equalToConstant: 300),

      verticalStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
      verticalStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
      verticalStackView.heightAnchor.constraint(equalToConstant: 110),
      verticalStackView.widthAnchor.constraint(equalToConstant: 300)
    ])
  }
}
