// FavoritesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана категорий
protocol FavoritesPresenterProtocol: AnyObject {
    /// Координатор флоу экрана
    var coordinator: FavoritesCoordinator? { get set }
    /// Инициализатор с присвоением вью
    init(view: FavoritesViewControllerProtocol, coordinator: FavoritesCoordinator, service: Service)
}

final class FavoritesPresenter: FavoritesPresenterProtocol {
    // MARK: - Public Properties

    weak var view: FavoritesViewControllerProtocol?
    var coordinator: FavoritesCoordinator?
    var service: Service

    var categories: [FoodModel] = []

    // MARK: - Initializers

    init(view: FavoritesViewControllerProtocol, coordinator: FavoritesCoordinator, service: Service) {
        self.view = view
        self.coordinator = coordinator
        self.service = service
    }
}
