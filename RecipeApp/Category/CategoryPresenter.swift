// CategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана категорий
protocol CategoryPresenterProtocol: AnyObject {
    /// Координатор флоу экрана
    var coordinator: CategoryCoordinator? { get set }
    /// Массив данных с продуктами
    var categories: [FoodModel] { get set }
    /// Массив данных с продуктами, используемый для поиска/
    var searchingCategories: [FoodModel] { get set }
    /// Инициализатор с присвоением вью
    init(view: CategoryViewControllerProtocol, coordinator: CategoryCoordinator, service: Service)
    /// Выход назад
    func moveBack()
    /// Открытие экрана описания рецепта
    func openRecipeDescriptionVC(model: FoodModel)
    /// Обработка нажатия на кнопку времени
    func sortingButtonPressed(_ state: ButtonState)
    /// Обработка нажатия на текстовое поле/
    func textFieldTapped(_ text: String)
    func viewDidLoaded()
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

    /// Переход назад
    func moveBack() {
        coordinator?.moveBack()
    }

    /// Открытие экрана описания рецепта
    func openRecipeDescriptionVC(model: FoodModel) {
        coordinator?.moveRecipeDescriptionVC(model: model)
    }

    /// Обработка нажатия на кнопку калорий
    func sortingButtonPressed(_ state: ButtonState) {
        switch state {
        case .normal:
            categories.shuffle()
            view?.updateView()
        case .highToLow:
            categories = categories.sorted(by: { $0.kkalCount < $1.kkalCount })
            view?.updateView()
        case .lowToHigh:
            categories = categories.sorted(by: { $0.kkalCount > $1.kkalCount })
            view?.updateView()
        }
    }

    /// Обработка нажатия на текстовое поле
    func textFieldTapped(_ text: String) {
        searchingCategories = categories.filter { $0.name.prefix(text.count) == text }
        isSearching = true
        view?.updateTextFieldSearching(isSearching)
    }

    func viewDidLoaded() {
        view?.showSkeleton()
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
            self.view?.offSkeleton()
        }
    }
}
