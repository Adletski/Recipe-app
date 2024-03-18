// RecipeCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Рутовый координатор для рецептов
final class RecipeCoordinator: BaseCoordinator {
    // MARK: - Properties

    var rootController: UINavigationController?
    var onFinishFlow: (() -> ())?

    // MARK: - Public Methods

    func setRootController(viewController: UIViewController) {
        rootController = UINavigationController(rootViewController: viewController)
    }

    func showCategory(category: RecipeCategories) {
        let categoryCoordinator = CategoryCoordinator()
        categoryCoordinator.category = category
        categoryCoordinator.start()
        categoryCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: categoryCoordinator)
        }
        if let viewController = categoryCoordinator.rootController {
            rootController?.pushViewController(viewController, animated: true)
        }
    }
}
