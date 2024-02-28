// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для вью рецептов
protocol RecipesView: AnyObject {}

/// Экран для рецептов
final class RecipesViewController: UIViewController, RecipesView {
    // MARK: - Properties

    var presenter: RecipesPresenter?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}
