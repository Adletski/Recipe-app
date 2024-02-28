// RecipesPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для презентера рецептов
protocol RecipesPresenter {
    init(view: RecipesView, coordinator: RecipeCoordinator)
}

/// Презентер для рецептов
final class RecipesPresenterImpl: RecipesPresenter {
    // MARK: - Properties

    weak var recipeCoordinator: RecipeCoordinator?
    weak var view: RecipesView?

    // MARK: - Initializer

    init(view: RecipesView, coordinator: RecipeCoordinator) {
        recipeCoordinator = coordinator
        self.view = view
    }
}
