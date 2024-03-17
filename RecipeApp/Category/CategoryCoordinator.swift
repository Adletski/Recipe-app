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
    var category: RecipeCategories?

    // MARK: - Lifecycle

    override func start() {
        let categoryViewController = CategoryViewController()
        let networkService = NetworkService()
        let categoryPresenter = CategoryPresenter(
            view: categoryViewController,
            coordinator: self,
            networkService: networkService,
            category: category ?? .fish
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
    func moveRecipeDescriptionVC(uri: String) {
        let recipeDescriptionViewController = RecipeDescriptionController()
        let recipeDescriptionPresenter = RecipeDescriptionPresenter(
            view: recipeDescriptionViewController,
            coordinator: self,
            uri: uri
        )
        recipeDescriptionViewController.presenter = recipeDescriptionPresenter
        rootController?.navigationController?.pushViewController(recipeDescriptionViewController, animated: true)
    }
}
