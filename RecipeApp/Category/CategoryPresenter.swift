// CategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана категорий
protocol CategoryPresenterProtocol: AnyObject {
    /// Координатор флоу экрана
    var coordinator: CategoryCoordinator? { get set }
    /// Массив данных с продуктами
    var categories: [FoodModel] { get set }
    var searchingCategories: [FoodModel] { get set }
    /// Инициализатор с присвоением вью
    init(view: CategoryViewControllerProtocol, coordinator: CategoryCoordinator, service: Service)
    /// Выход назад
    func moveBack()
    func openRecipeDescriptionVC(model: FoodModel)
    func timeButtonPressed(_ bool: Bool)
    func caloriesButtonPressed(_ bool: Bool)
    func textFieldTapped(_ text: String)
}

final class CategoryPresenter: CategoryPresenterProtocol {
    // MARK: - Public Properties

    weak var view: CategoryViewControllerProtocol?
    var coordinator: CategoryCoordinator?
    var service: Service
    var categories: [FoodModel] = []

    var searchingCategories: [FoodModel] = []
    var isSearching = false

    // MARK: - Initializers

    init(view: CategoryViewControllerProtocol, coordinator: CategoryCoordinator, service: Service) {
        self.view = view
        self.coordinator = coordinator
        self.service = service
        categories = service.getCategoryList()
    }

    // MARK: - Public methods

    func moveBack() {
        coordinator?.moveBack()
    }

    func openRecipeDescriptionVC(model: FoodModel) {
        coordinator?.moveRecipeDescriptionVC(model: model)
    }

    func caloriesButtonPressed(_ bool: Bool) {
        if bool {
            categories = categories.sorted(by: { $0.kkalCount < $1.kkalCount })
            view?.updateWithCalories()
        } else {
            categories = categories.shuffled()
            view?.updateWithCalories()
        }
    }

    func timeButtonPressed(_ bool: Bool) {
        if bool {
            categories = categories.sorted(by: { $0.timeCount < $1.timeCount })
            view?.updateWithTime()
        } else {
            categories = categories.shuffled()
            view?.updateWithTime()
        }
    }

    func textFieldTapped(_ text: String) {
        searchingCategories = categories.filter { $0.name.prefix(text.count) == text }
        isSearching = true
        view?.updateTextFieldSearching(isSearching)
    }
}
