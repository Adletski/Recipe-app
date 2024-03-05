// RecipeDescriptionCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Координатор для профиля
final class RecipeDescriptionCoordinator: BaseCoordinator {
    // MARK: - Properties

    var rootController: UINavigationController?
    var onFinishFlow: (() -> ())?

    // MARK: - Initializer

    func setupRootController(viewController: UIViewController) {
        rootController = UINavigationController(rootViewController: viewController)
    }

    func moveBack() {
        rootController?.navigationController?.popViewController(animated: true)
    }
}
