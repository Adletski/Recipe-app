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
    var recipes: [Recipe] { get set }
    /// Массив данных с продуктами, используемый для поиска/
    var searchingCategories: [Recipe] { get set }
    /// Инициализатор с присвоением вью
    init(view: CategoryViewControllerProtocol, coordinator: CategoryCoordinator, networkService: NetworkServiceProtocol)
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
    func getRecipes()
}

final class CategoryPresenter: CategoryPresenterProtocol {
    // MARK: - Public Properties

    weak var view: CategoryViewControllerProtocol?
    var coordinator: CategoryCoordinator?
    var networkService: NetworkServiceProtocol
    var unfilteredRecipes: Recipes? {
        didSet {
            unfilteredRecipes?.hits.forEach {
                recipes.append($0.recipe)
            }
            print(recipes)
        }
    }

    var recipes: [Recipe] = []
    var searchingCategories: [Recipe] = []
    var isSearching = false
    var isShowSkeleton = false

    // MARK: - Initializers

    init(
        view: CategoryViewControllerProtocol,
        coordinator: CategoryCoordinator,
        networkService: NetworkServiceProtocol
    ) {
        self.view = view
        self.coordinator = coordinator
        self.networkService = networkService
        getRecipes()
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
            recipes.shuffle()
            view?.updateView()
        case .highToLow:
//            recipes = recipes.sorted(by: { $0.kkalCount < $1.kkalCount })
            view?.updateView()
        case .lowToHigh:
//            recipes = recipes.sorted(by: { $0.kkalCount > $1.kkalCount })
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
//        searchingCategories = recipes.filter { $0.name.prefix(text.count) == text }
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
            recipes = recipes.shuffled()
            view?.updateView()
        case .highToLow:
//            recipes = recipes.sorted(by: { $0.kkalCount > $1.kkalCount })
            view?.updateView()
        case .lowToHigh:
//            recipes = recipes.sorted(by: { $0.kkalCount < $1.kkalCount })
            view?.updateView()
        }
    }

    func getRecipes() {
        networkService.getRecipes { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success(recipes):
                self?.unfilteredRecipes = recipes
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
