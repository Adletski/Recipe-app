// RecipeDescriptionController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с рецептом
final class RecipeDescriptionController: UIViewController {
    // MARK: - Constants

    /// Перечисление, используемые в контроллере рецепта
    enum Constant {
        /// Изображения стрелки
        static let arrowImage = "arrow"
        /// Изображения кнопки отправки
        static let sendButtonImage = "sendButtonImage"
        /// Изображения кнопки сохранения
        static let savedButtonImage = "savedButtonImage"
    }

    /// Перечисление для  деталей рецепта
    enum Details {
        /// Фото
        case photo
        /// Характеристики
        case characteristics
        /// Описание
        case description
    }

    /// Выбранный рецепт
    var selectedRecipe: FoodModel? {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Private properties

    private let range: [Details] = [.photo, .characteristics, .description]
    private let recipeCells: [Details] = [.photo, .characteristics, .description]
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()

    // MARK: - Public properties

    var presenter: RecipeDescriptionPresenterProtocol?

    // MARK: - Visual Components

    private let backBarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constant.arrowImage), for: .normal)
        return button
    }()

    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constant.sendButtonImage), for: .normal)
        return button
    }()

    private let setFavorite: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constant.savedButtonImage), for: .normal)
        return button
    }()

    private let barView = UIView()

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        presenter?.viewDidLoaded()
        setupRefreshControl()
    }

    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func endRefreshing() {
        refreshControl.endRefreshing()
    }

    // MARK: - Private Methods

    private func setupView() {
        view.backgroundColor = .red
        view.addSubview(tableView)
        setupTableView()
    }

    private func setupNavigationBar() {
        let backButton = UIBarButtonItem(
            image: UIImage(named: Constant.arrowImage),
            style: .done,
            target: self,
            action: #selector(backButtonPressed)
        )
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        let shareBarButton = UIBarButtonItem(customView: shareButton)
        let setFavoriteBarButton = UIBarButtonItem(
            image: UIImage(named: Constant.savedButtonImage),
            style: .plain,
            target: self,
            action: #selector(favoriteButtonPressed)
        )
        navigationItem.rightBarButtonItems = [setFavoriteBarButton, shareBarButton]
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.register(RecipeImageCell.self, forCellReuseIdentifier: RecipeImageCell.identifier)
        tableView.register(RecipeECFPCell.self, forCellReuseIdentifier: RecipeECFPCell.identifier)
        tableView.register(RecipeTextCell.self, forCellReuseIdentifier: RecipeTextCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }

    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    // MARK: - IBAction

    @objc private func refreshData(_ sender: UIRefreshControl) {
        presenter?.refreshData()
    }

    // @objc private func refreshData(_ sender: UIRefreshControl) {
//        presenter?.getDetailRecipes()
    // }

    /// Обработчик нажатия кнопки "назад"
    @objc private func backButtonPressed() {
        presenter?.moveBack()
    }

    /// Обработчик нажатия кнопки "добавить в избранное"
    @objc private func favoriteButtonPressed() {
        var favorites: [FoodModel] = []
        if let selectedRecipe {
            favorites.append(selectedRecipe)
        }
        if let savedData = UserDefaults.standard.object(forKey: "favorites") as? Data {
            do {
                let savedContacts = try JSONDecoder().decode([FoodModel].self, from: savedData)
                favorites = savedContacts
            } catch {
                print(error.localizedDescription)
            }
        }

        if !(favorites.contains { $0.name == selectedRecipe?.name }) {
            if let selectedRecipe {
                favorites.append(selectedRecipe)
            }
        }
        do {
            let encodedData = try JSONEncoder().encode(favorites)
            UserDefaults.standard.set(encodedData, forKey: "favorites")
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - Extension

extension RecipeDescriptionController: UITableViewDataSource {
    /// Определяет количество секций в таблице
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    /// Определяет количество строк в указанной секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    /// Создает и возвращает ячейку для определенной позиции
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = range[indexPath.section]
        switch cells {
        case .photo:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecipeImageCell.identifier,
                for: indexPath
            ) as? RecipeImageCell else {
                return UITableViewCell()
            }
            if let recipe = presenter?.detailRecipe {
                cell.configure(recipe: FoodModel(
                    image: recipe.imagesUrl,
                    name: recipe.label,
                    title: recipe.label,
                    time: recipe.totalTime,
                    timeCount: Int(recipe.totalTime) ?? 0,
                    kkal: recipe.calories,
                    kkalCount: Int(recipe.calories) ?? 0,
                    weight: Int(recipe.totalWeight) ?? 0,
                    carbohydrates: recipe.carbohydrates,
                    fats: recipe.fats,
                    proteins: recipe.proteins,
                    descriptions: recipe.ingredients.joined(separator: "\n")
                ))
            }
            return cell
        case .characteristics:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecipeECFPCell.identifier,
                for: indexPath
            ) as? RecipeECFPCell else {
                return UITableViewCell()
            }
            if let recipe = presenter?.detailRecipe {
                cell.configure(recipe: FoodModel(
                    timeCount: Int(recipe.totalTime) ?? 0,
                    kkal: recipe.calories,
                    kkalCount: Int(recipe.calories) ?? 0,
                    carbohydrates: recipe.carbohydrates,
                    fats: recipe.fats,
                    proteins: recipe.proteins
                ))
            }
            return cell
        case .description:
            print("description")
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecipeTextCell.identifier,
                for: indexPath
            ) as? RecipeTextCell else {
                return UITableViewCell()
            }
            print(presenter?.detailRecipe?.ingredients)
            if let recipeDescriptions = presenter?.detailRecipe?.ingredients.joined(separator: "\n") {
                cell.configure(recipe: FoodModel(
                    descriptions: recipeDescriptions
                ))
            }
            return cell
        }
    }
}

extension RecipeDescriptionController: UITableViewDelegate {
    /// Возвращает высоту строки для ячейки по указанному индекy
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType = range[indexPath.section]
        switch cellType {
        case .photo:
            return 300
        case .characteristics:
            return 90
        case .description:
            return 650
        }
    }
}
