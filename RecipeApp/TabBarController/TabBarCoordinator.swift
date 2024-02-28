// TabBarCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Координатор для таб бара
final class TabBarCoordinator {
    // MARK: - Properties

//    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Public methods

    func start() {
        let vc = TabBarViewController()
        vc.setViewControllers(
            [
                RecipesBuilder.createRecipe(),
                createFavorites(),
                ProfileBuilder.createProfile()
            ],
            animated: true
        )
        navigationController.pushViewController(vc, animated: true)
    }
}

// MARK: - TabBarCoordinator extension

extension TabBarCoordinator {
    func createFavorites() -> FavoritesViewController {
        let viewController = FavoritesViewController()
        viewController.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(named: "favorites"),
            selectedImage: UIImage(named: "favoritesFilled")
        )
        viewController.coordinator = self
        return viewController
    }
}
