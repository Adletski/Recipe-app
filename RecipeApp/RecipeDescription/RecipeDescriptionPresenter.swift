// RecipeDescriptionPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol RecipeDescriptionPresenterProtocol {
    /// Координатор флоу экрана
    var coordinator: CategoryCoordinator? { get set }
    /// Массив данных с продуктами
    var detailRecipe: DetaliesResipe? { get set }
    /// URI рецепта
    var uri: String { get set }
    /// Инициализатор с присвоением вью
    init(view: RecipeDescriptionController, coordinator: CategoryCoordinator, uri: String)
    /// Выход назад
    func moveBack()
    /// Метод вызывается при загрузке вью
    func viewDidLoaded()
    /// Обновление деталей рецепта
    func updateRecipeDetails(_ details: DetaliesResipe)
    /// Обновление данных
    func refreshData()
    /// Метод для окончания обновления данных
    func endRefreshing()
}

/// Презентор для деталей рецепта
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

    /// Получение деталей рецепта
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

    /// Переход назад
    func moveBack() {
        coordinator?.moveBack()
    }

    /// Метод вызывается при загрузке вью
    func viewDidLoaded() {
        view?.reloadTableView()
    }

    /// Обновление деталей рецепта
    func updateRecipeDetails(_ details: DetaliesResipe) {
        detailRecipe = details
        view?.reloadTableView()
    }

    /// Обновление данных
    func refreshData() {
        getDetailRecipes()
    }

    /// Метод для окончания обновления данных
    func endRefreshing() {
        view?.endRefreshing()
    }
}
