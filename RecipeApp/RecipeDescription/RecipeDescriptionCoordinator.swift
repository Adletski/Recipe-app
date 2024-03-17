// RecipeDescriptionCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор для профиля
final class RecipeDescriptionCoordinator: BaseCoordinator {
    // MARK: - Properties

    var rootController: UINavigationController?
    var onFinishFlow: (() -> ())?

    // MARK: - Public Methods

    // Устанавливает корневой контроллер навигации координатора
    func setupRootController(viewController: UIViewController) {
        rootController = UINavigationController(rootViewController: viewController)
    }

    /// Перемещает назад на один контроллер в стеке навигации
    func moveBack() {
        rootController?.navigationController?.popViewController(animated: true)
    }
}
