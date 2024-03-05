// RecipeDescriptionPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol RecipeDescriptionPresenterProtocol {
    /// Координатор флоу экрана
    var coordinator: CategoryCoordinator? { get set }
    /// Массив данных с продуктами
    var category: FoodModel? { get set }
    /// Инициализатор с присвоением вью
    init(view: RecipeDescriptionController, coordinator: CategoryCoordinator)
    /// Выход назад
    func moveBack()
}

final class RecipeDescriptionPresenter: RecipeDescriptionPresenterProtocol {
    // MARK: - Public Properties

    var coordinator: CategoryCoordinator?
    weak var view: RecipeDescriptionController?
    var category: FoodModel?

    init(view: RecipeDescriptionController, coordinator: CategoryCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }

    func moveBack() {
        print("presenter back")
        coordinator?.moveBack()
    }
}
