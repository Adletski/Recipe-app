// CategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана категорий
protocol CategoryPresenterProtocol: AnyObject {
    /// Координатор флоу экрана
    var coordinator: CategoryCoordinator? { get set }
    /// Массив данных с продуктами
    var categories: [FoodModel] { get set }
    /// Инициализатор с присвоением вью
    init(view: CategoryViewControllerProtocol, coordinator: CategoryCoordinator, service: Service)
    /// Выход назад
    func moveBack()
}

final class CategoryPresenter: CategoryPresenterProtocol {
    // MARK: - Public Properties

    weak var view: CategoryViewControllerProtocol?
    var coordinator: CategoryCoordinator?
    var service: Service
    var categories: [FoodModel] = []

    // MARK: - Initializers

    init(view: CategoryViewControllerProtocol, coordinator: CategoryCoordinator, service: Service) {
        self.view = view
        self.coordinator = coordinator
        self.service = service
        categories = service.getCategoryList()
    }

    // MARK: - Public methods

    func moveBack() {
        coordinator?.moveBack()
    }
}
