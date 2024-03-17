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
    var state: ViewState<[Recipe]> { get set }
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
    /// Обработка  нажатися отмены серчбара
    func cancelButtonPressed()
    /// Обработка нажатия на кнопку фильтра
    func filterButtonPressed(state: ButtonState)
    /// фывфывф
    func getRecipes(category: RecipeCategories)
    /// фывфыв
    var category: RecipeCategories { get set }
    /// asdasd
    func reloadButtonPressed()
    /// asdasda
    var networkService: NetworkServiceProtocol { get set }
}

/// фывфыв
enum ViewState<Model> {
    case loading
    case data(_ model: Model)
    case noData
    case error(_ error: Error)
}

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
        getRecipes(dishType: "Salad")
    }

    func reloadButtonPressed() {
        state = .loading
        getRecipes(dishType: "Salad")
    }

    private func getRecipes(dishType: String) {
        networkService.getRecipes(dishType: dishType) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(recipes):
                    self?.state = !recipes.isEmpty ? .data(recipes) : .noData
                case let .failure(error):
                    print("error")
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
