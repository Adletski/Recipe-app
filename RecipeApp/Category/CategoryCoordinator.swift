// CategoryCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор для категорий
final class CategoryCoordinator: BaseCoordinator {
    // MARK: - Properties

    /// Корневой контроллер координатора
    var rootController: UIViewController?
    /// Замыкание, вызываемое по завершению флоу
    var onFinishFlow: (() -> ())?

    // MARK: - Lifecycle

    override func start() {
        let categoryViewController = CategoryViewController()
        let networkService = NetworkService()
        let categoryPresenter = CategoryPresenter(
            view: categoryViewController,
            coordinator: self,
            networkService: networkService
        )
        categoryViewController.presenter = categoryPresenter
        rootController = categoryViewController
    }

    // MARK: - Public methods

    /// Возврат назад
    func moveBack() {
        rootController?.navigationController?.popViewController(animated: true)
    }

    /// Переход на экран описания рецепта
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
