// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для презентера рецептов
protocol RecipesPresenterProtocol {
    /// инъекция зависимостей
    init(view: RecipesView, coordinator: RecipeCoordinator)
    /// нажатие кнопки
    func buttonPressed()
}

/// Презентер для рецептов
final class RecipesPresenterImpl: RecipesPresenterProtocol {
    // MARK: - Properties

    weak var recipeCoordinator: RecipeCoordinator?
    weak var view: RecipesView?

    // MARK: - Initializer

    init(view: RecipesView, coordinator: RecipeCoordinator) {
        recipeCoordinator = coordinator
        self.view = view
    }

    func buttonPressed() {
        recipeCoordinator?.openCategory()
    }
}
