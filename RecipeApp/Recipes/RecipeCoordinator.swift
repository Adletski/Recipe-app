// RecipeCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Рутовый координатор для рецептов
final class RecipeCoordinator: BaseCoordinator {
    // MARK: - Properties

    var rootController: UINavigationController
    var onFinishFlow: (() -> ())?

    // MARK: - Initializer

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }
}
