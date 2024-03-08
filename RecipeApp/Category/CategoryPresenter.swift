// CategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана категорий
protocol CategoryPresenterProtocol: AnyObject {
    var isSearching: Bool { get set }
    var isShowSkeleton: Bool { get set }
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
    /// Оповещение презентера о прогрузке вью
    func viewDidLoaded()
    /// Делегат для серчбара с передачей текста
    func searchBarDelegate(_ text: String)
    /// Обработка  нажатися отмены серчбара
    func cancelButtonPressed()
    /// Обработка нажатия на кнопку фильтра
    func filterButtonPressed(state: ButtonState)
}

final class CategoryPresenter: CategoryPresenterProtocol {
    // MARK: - Public Properties

    weak var view: CategoryViewControllerProtocol?
    var coordinator: CategoryCoordinator?
    var service: Service
    var categories: [FoodModel] = []
    var searchingCategories: [FoodModel] = []
    var isSearching = false
    var isShowSkeleton = false

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

    func viewDidLoaded() {
        isShowSkeleton = true
        view?.updateView()
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [weak self] _ in
            self?.isShowSkeleton = false
            self?.view?.updateView()
        }
    }

    func searchBarDelegate(_ text: String) {
        searchingCategories = categories.filter { $0.name.prefix(text.count) == text }
        isSearching = true
        view?.updateView()
    }

    func cancelButtonPressed() {
        isSearching = false
        view?.updateSearchBar()
    }

    func filterButtonPressed(state: ButtonState) {
        switch state {
        case .normal:
            categories = categories.shuffled()
            view?.updateView()
        case .highToLow:
            categories = categories.sorted(by: { $0.kkalCount > $1.kkalCount })
            view?.updateView()
        case .lowToHigh:
            categories = categories.sorted(by: { $0.kkalCount < $1.kkalCount })
            view?.updateView()
        }
    }
}
