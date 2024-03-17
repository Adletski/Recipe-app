// CategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана категорий
protocol CategoryPresenterProtocol: AnyObject {
    /// Происходит ли поиск
    var isSearching: Bool { get set }
    /// Отображается ли шимер
    var isShowSkeleton: Bool { get set }
    /// Координатор флоу экрана
    var coordinator: CategoryCoordinator? { get set }
    /// Массив данных с продуктами
    var recipes: [Recipe] { get set }
    /// Массив данных с продуктами, используемый для поиска/
    var searchingCategories: [Recipe] { get set }
    /// Состояние представления
    var state: ViewState<[Recipe]> { get set }
    /// Сервис для работы с сетью
    var networkService: NetworkServiceProtocol { get set }
    /// Категория рецептов
    var category: RecipeCategories { get set }
    /// Инициализатор с присвоением вью
    init(
        view: CategoryViewControllerProtocol,
        coordinator: CategoryCoordinator,
        networkService: NetworkServiceProtocol,
        category: RecipeCategories
    )
    /// Выход назад
    func moveBack()
    /// Открытие экрана описания рецепта
    func openRecipeDescriptionVC(uri: String)
    /// Оповещение презентера о прогрузке вью
    func viewDidLoaded()
    /// Делегат для серчбара с передачей текста
    func searchBarDelegate(_ text: String)
    /// Обработка  нажатия отмены серчбара
    func cancelButtonPressed()
    /// Обработка нажатия на кнопку фильтра
    func filterButtonPressed(state: ButtonState)
    /// Получение списка рецептов по категории
    func getRecipes(category: RecipeCategories)
    /// Обработка нажатия на кнопку обновления
    func reloadButtonPressed()
    
}

/// Состояние представления
enum ViewState<Model> {
    ///Загрузка
    case loading
    /// Данные модели
    case data(_ model: Model)
    /// Нет данных
    case noData
    /// Ошибка
    case error(_ error: Error)
}
/// Презентер экрана категорий
final class CategoryPresenter: CategoryPresenterProtocol {
    // MARK: - Public Properties

    weak var view: CategoryViewControllerProtocol?
    var coordinator: CategoryCoordinator?
    var networkService: NetworkServiceProtocol
    var recipes: [Recipe] = []
    var searchingCategories: [Recipe] = []
    var isSearching = false
    var isShowSkeleton = false
    var category: RecipeCategories
    var state: ViewState<[Recipe]> = .loading {
        didSet {
            view?.updateState()
        }
    }

    // MARK: - Initializers

    init(
        view: CategoryViewControllerProtocol,
        coordinator: CategoryCoordinator,
        networkService: NetworkServiceProtocol,
        category: RecipeCategories
    ) {
        self.view = view
        self.coordinator = coordinator
        self.networkService = networkService
        self.category = category
    }

    // MARK: - Public methods

    /// Переход назад
    func moveBack() {
        coordinator?.moveBack()
    }

    /// Открытие экрана описания рецепта
    func openRecipeDescriptionVC(uri: String) {
        coordinator?.moveRecipeDescriptionVC(uri: uri)
    }

    func viewDidLoaded() {
        print(category.rawValue, "viewdidloaded")
        getRecipes(dishType: category.rawValue)
    }

    func reloadButtonPressed() {
        state = .loading
        getRecipes(dishType: category.rawValue)
    }

    private func getRecipes(dishType: String) {
        networkService.getRecipes(dishType: dishType) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(recipes):
                    self?.state = !recipes.isEmpty ? .data(recipes) : .noData
                case let .failure(error):
                    self?.state = .error(error)
                }
            }
        }
    }

    func searchBarDelegate(_ text: String) {
//        searchingCategories = recipes.filter { $0.name.prefix(text.count) == text }
//        isSearching = true
//        view?.updateView()
    }

    func cancelButtonPressed() {
//        isSearching = false
//        view?.updateSearchBar()
    }

    func filterButtonPressed(state: ButtonState) {
//        switch state {
//        case .normal:
//            recipes = recipes.shuffled()
//            view?.updateView()
//        case .highToLow:
        ////            recipes = recipes.sorted(by: { $0.kkalCount > $1.kkalCount })
//            view?.updateView()
//        case .lowToHigh:
        ////            recipes = recipes.sorted(by: { $0.kkalCount < $1.kkalCount })
//            view?.updateView()
//        }
    }

    func getRecipes(category: RecipeCategories) {
//        var categoryTitle = ""
//        switch category {
//        case .salad:
//            categoryTitle = "Salad"
//        case .soup:
//            categoryTitle = "Soup"
//        case .chicken:
//            categoryTitle = "Main course"
//        case .meat:
//            categoryTitle = "Main course"
//        case .fish:
//            categoryTitle = "Main course"
//        case .sideDish:
//            categoryTitle = "Main course"
//        case .drinks:
//            categoryTitle = "Drinks"
//        case .pancakes:
//            categoryTitle = "Pancakes"
//        case .desserts:
//            categoryTitle = "Desserts"
//        }
//        networkService.getRecipes(dishType: categoryTitle) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case let .success(recipes):
//                self.recipes = recipes
//                self.view?.updateRecipes(recipes)
//            case let .failure(error):
//                print("Ошибка: \(error.localizedDescription)")
//            }
//        }
    }
}
