// RecipesBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Билд для модуля рецептов
final class RecipesBuilder {
    enum Constants {
        static let title = "Recipes"
    }
    // MARK: - Public Methods
    static func createRecipe(coordinator: RecipeCoordinator) -> RecipesViewController {
        let viewController = RecipesViewController()
        let recipePresenter = RecipesPresenter(view: viewController, coordinator: coordinator)
        viewController.presenter = recipePresenter
        viewController.tabBarItem = UITabBarItem(
            title: Constants.title,
            image: UIImage(named: "recipes"),
            selectedImage: UIImage(named: "recipesFilled")
        )
        return viewController
    }
}
