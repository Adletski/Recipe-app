// TabBarCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

final class TabBarCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = TabBarViewController()
        vc.setViewControllers(
            [
                RecipesBuilder.createRecipe(coordinator: self),
                createFavorites(),
                ProfileBuilder.createProfile(coordinator: self)
            ],
            animated: true
        )
        navigationController.pushViewController(vc, animated: true)
    }
}

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
