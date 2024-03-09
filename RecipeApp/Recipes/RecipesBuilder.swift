// RecipesBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Билд для модуля рецептов
final class RecipesBuilder {
    enum Constant {
        static let title = "Recipes"
        static let recipes = "recipes"
        static let recipesFilled = "recipesFilled"
    }

    // MARK: - Public Methods

    static func createRecipe(coordinator: RecipeCoordinator) -> RecipesViewController {
        let viewController = RecipesViewController()
        let recipePresenter = RecipesPresenter(view: viewController, coordinator: coordinator)
        viewController.presenter = recipePresenter
        viewController.tabBarItem = UITabBarItem(
            title: Constant.title,
            image: UIImage(named: Constant.recipes),
            selectedImage: UIImage(named: Constant.recipesFilled)
        )
        return viewController
    }
}
