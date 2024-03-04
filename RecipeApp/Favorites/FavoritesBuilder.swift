// FavoritesBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Билд для модуля рецептов
final class FavoritesBuilder {
    static func createFavorites(coordinator: FavoritesCoordinator) -> FavoritesViewController {
        let viewController = FavoritesViewController()
        let service = Service()
        let favoritesPresenter = FavoritesPresenter(view: viewController, coordinator: coordinator, service: service)
        viewController.presenter = favoritesPresenter
        viewController.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(named: "favorites"),
            selectedImage: UIImage(named: "favoritesFilled")
        )
        return viewController
    }
}
