// RecipesBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Билд для модуля рецептов
final class RecipesBuilder {
    static func createRecipe() -> RecipesViewController {
        let viewController = RecipesViewController()
        viewController.tabBarItem = UITabBarItem(
            title: "Recipes",
            image: UIImage(named: "recipes"),
            selectedImage: UIImage(named: "recipesFilled")
        )
        viewController.presenter = RecipesPresenterImpl()
        return viewController
    }
}
