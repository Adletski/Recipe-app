// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// MARK: - Types

/// Протокол презентера экрана рецептов
protocol RecipesViewPresenterProtocol: AnyObject {
    /// Координатор флоу экрана
    var coordinator: RecipeCoordinator? { get set }
    /// Инициализатор с присвоением вью
    init(view: RecipesView)
    /// Получить информацию о категории по номеру
    func getInfo(categoryNumber: Int) -> DishCategory
    /// Получить количество категорий
    func getCategoryCount() -> Int
    /// Перейти к выбранной категории
    func goToCategory(_ category: RecipeCategories)
}

/// Презентер экрана рецептов
final class RecipesPresenter: RecipesViewPresenterProtocol {
    // MARK: - Private Properties

    private let recipeCatalog = RecipeCatalog()

    // MARK: - Initializers

    required init(view: RecipesView) {
        self.view = view
    }

    // MARK: - Public Properties

    weak var coordinator: RecipeCoordinator?
    weak var view: RecipesView?

    // MARK: - Public Methods

    /// Получить информацию о категории по номеру
    func getInfo(categoryNumber: Int) -> DishCategory {
        recipeCatalog.categories[categoryNumber]
    }

    /// Получить количество категорий
    func getCategoryCount() -> Int {
        recipeCatalog.categories.count
    }

    /// Перейти к выбранной категории
    func goToCategory(_ category: RecipeCategories) {}
}
