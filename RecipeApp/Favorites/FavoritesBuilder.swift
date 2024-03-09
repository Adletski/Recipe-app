// FavoritesBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Билд для модуля рецептов
final class FavoritesBuilder {
    // MARK: - Public Methods

    /// Создает экран избранных для использования в приложении
    static func createFavorites(coordinator: FavoritesCoordinator) -> FavoritesViewController {
        /// Создание экземпляра FavoritesViewController
        let viewController = FavoritesViewController()
        /// Создание экземпляра "сервис" для работы с данными избранных
        let service = Service()
        // Создание презентера для управления отображением экрана избранных
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
