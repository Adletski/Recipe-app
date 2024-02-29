// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для вью рецептов
protocol RecipesView: AnyObject {}

/// Экран для рецептов
final class RecipesViewController: UIViewController, RecipesView {
    let button = UIButton()

    // MARK: - Properties

    var presenter: RecipesPresenterProtocol?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        title = "Recipes"
        navigationController?.navigationBar.prefersLargeTitles = true

        button.setTitle("next", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func buttonPressed() {}
}
