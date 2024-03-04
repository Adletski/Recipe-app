// CategoryCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор для категорий
final class CategoryCoordinator: BaseCoordinator {
    // MARK: - Properties

    var rootController: UIViewController?
    var onFinishFlow: (() -> ())?

    // MARK: - Lifecycle

    override func start() {
        let categoryViewController = CategoryViewController()
        let service = Service()
        let categoryPresenter = CategoryPresenter(view: categoryViewController, coordinator: self, service: service)
        categoryViewController.presenter = categoryPresenter
        rootController = categoryViewController
    }

    // MARK: - Public methods

    func moveBack() {
        rootController?.navigationController?.popViewController(animated: true)
    }

    func moveRecipeDescriptionVC(model: FoodModel) {
        let recipeDescriptionViewController = RecipeDescriptionController()
        let recipeDescriptionPresenter = RecipeDescriptionPresenter(
            view: recipeDescriptionViewController,
            coordinator: self
        )
        recipeDescriptionViewController.selectedRecipe = model
        recipeDescriptionViewController.presenter = recipeDescriptionPresenter

        rootController?.navigationController?.pushViewController(recipeDescriptionViewController, animated: true)
    }
}
