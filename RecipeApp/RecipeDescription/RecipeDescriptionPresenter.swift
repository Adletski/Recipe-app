// RecipeDescriptionPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol RecipeDescriptionPresenterProtocol {
    /// Координатор флоу экрана
    var coordinator: CategoryCoordinator? { get set }
    /// Массив данных с продуктами
    var detailRecipe: DetaliesResipe? { get set }
    var uri: String { get set }
    /// Инициализатор с присвоением вью
    init(view: RecipeDescriptionController, coordinator: CategoryCoordinator, uri: String)
    /// Выход назад
    func moveBack()
    func viewDidLoaded()
    func updateRecipeDetails(_ details: DetaliesResipe)
    func refreshData()
}

final class RecipeDescriptionPresenter: RecipeDescriptionPresenterProtocol {
    // MARK: - Public Properties

    var coordinator: CategoryCoordinator?
    weak var view: RecipeDescriptionController?
    var detailRecipe: DetaliesResipe? {
        didSet {
            view?.reloadTableView()
        }
    }

    var uri: String
    var networkService = NetworkService()

    // MARK: - Initializer

    init(view: RecipeDescriptionController, coordinator: CategoryCoordinator, uri: String) {
        self.view = view
        self.coordinator = coordinator
        self.uri = uri
        getDetailRecipes()
    }

    // MARK: - Public methods

    func getDetailRecipes() {
        networkService.getDetailRecipe(uri: uri) { [weak self] result in
            switch result {
            case let .success(detailRecipe):
                print(detailRecipe)
                // self?.detailRecipe = detailRecipe
                self?.updateRecipeDetails(detailRecipe)
                print(detailRecipe)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    func moveBack() {
        coordinator?.moveBack()
    }

    func viewDidLoaded() {
        view?.reloadTableView()
    }

    func updateRecipeDetails(_ details: DetaliesResipe) {
        detailRecipe = details
        view?.reloadTableView()
    }

    func refreshData() {
        getDetailRecipes()
    }
}
