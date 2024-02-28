// RecipeCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Рутовый координатор для рецептов
final class RecipeCoordinator: BaseCoordinator {
    // MARK: - Properties

    var rootController: UINavigationController?
    var onFinishFlow: (() -> ())?

    // MARK: - Initializer

    func setRootController(viewController: UIViewController) {
        rootController = UINavigationController(rootViewController: viewController)
    }

    func openCategory() {
        let vc = CategoryViewController()
        rootController?.pushViewController(vc, animated: true)
    }
}
