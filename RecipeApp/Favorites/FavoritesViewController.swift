// FavoritesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран для фаворитных продуктов
final class FavoritesViewController: UIViewController {
    // MARK: - Properties

    weak var coordinator: TabBarCoordinator?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
}
