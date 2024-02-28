// TabBarViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вьюконтроллер для таб бара
final class TabBarViewController: UITabBarController {
    // MARK: - Properties

    weak var coordinator: TabBarCoordinator?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        print("")
    }
}
