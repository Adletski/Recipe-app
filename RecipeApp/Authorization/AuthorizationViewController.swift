// AuthorizationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class AuthorizationViewController: UIViewController {
    private let helloLabel = UILabel()
    private let nextButton = UIButton()
    var presenter: AuthPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        helloLabel.text = "Hello"
        helloLabel.font = .systemFont(ofSize: 20)
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(helloLabel)

        nextButton.setTitle("next", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        view.addSubview(nextButton)

        helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        nextButton.topAnchor.constraint(equalTo: helloLabel.bottomAnchor, constant: 10).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    @objc func nextButtonPressed() {
        print("controller")
        presenter?.nextButtonPressed()
    }
}
