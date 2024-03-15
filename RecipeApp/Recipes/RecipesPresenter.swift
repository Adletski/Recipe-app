// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// MARK: - Types

/// Протокол презентера экрана рецептов
protocol RecipesViewPresenterProtocol: AnyObject {
    /// Координатор флоу экрана
    var coordinator: RecipeCoordinator? { get set }
    /// Инициализатор с присвоением вью
    init(view: RecipesView, coordinator: RecipeCoordinator)
    /// Получить информацию о категории по номеру
    func getInfo(categoryNumber: Int) -> DishCategory
    /// Получить количество категорий
    func getCategoryCount() -> Int
    /// Перейти к выбранной категории
    func goToCategory(_ category: RecipeCategories)
    var recipeCatalog: RecipeCatalog { get set }
    func cellDidTap(dish: String)
}

/// Презентер экрана рецептов
final class RecipesPresenter: RecipesViewPresenterProtocol {
    // MARK: - Private Properties

    var recipeCatalog = RecipeCatalog()
    private let networkService: NetworkServiceProtocol

    // MARK: - Initializers

    required init(view: RecipesView, coordinator: RecipeCoordinator) {
        self.view = view
        self.coordinator = coordinator
        networkService = NetworkService()
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
    func goToCategory(_ category: RecipeCategories) {
        coordinator?.showCategory()
    }

    func cellDidTap(dish: String) {
        /// Загрузка рецептов для определенного типа блюда
        networkService.getRecipes(dishType: dish) { result in
            switch result {
            case let .success(recipes):
                /// Вызов метода для отображения загруженных рецептов
                self.view?.showRecipes(recipes)
            case let .failure(error):
                print("Error loading recipes: \(error)")
            }
        }
    }
}
