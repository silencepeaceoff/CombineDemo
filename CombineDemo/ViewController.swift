//
//  ViewController.swift
//  CombineDemo
//
//  Created by Dmitrii Tikhomirov on 5/16/23.
//

import UIKit
import Combine

extension Notification.Name {
  static let newBlogPost = Notification.Name("newPost")
}

struct BlogPost {
  let title: String
}

final class ViewController: UIViewController {

  private let newView = NewView()

  override func viewDidLoad() {
    super.viewDidLoad()

    setupViewController()
    makeConstraints()

    newView.publishButton.addTarget(self, action: #selector(publishButtonTapped), for: .primaryActionTriggered)

    // Create a publisher
    let publisher = NotificationCenter.Publisher(center: .default, name: .newBlogPost, object: nil)
      .map { (notification) -> String? in // Combine with an operator
        (notification.object as? BlogPost)?.title ?? ""
      }

    // Create a subscriber
    let subscriber = Subscribers.Assign(object: newView.subscribedLabel, keyPath: \.text)
    publisher.subscribe(subscriber)
  }
}

extension ViewController {
  func setupViewController() {
    view.backgroundColor = .systemBackground
    view.addSubview(newView)
  }

  func makeConstraints() {
    newView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      newView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      newView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      newView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      newView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }

  @objc func publishButtonTapped(_ sender: UIButton) {
    // Post the notification
    let title = newView.blogTextField.text ?? "Coming soon"
    let blogPost = BlogPost(title: title)
    NotificationCenter.default.post(name: .newBlogPost, object: blogPost)
  }
}
