// CategoryViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для категорий еды
protocol CategoryViewControllerProtocol: AnyObject {}

/// Экран для категорий еды
final class CategoryViewController: UIViewController, CategoryViewControllerProtocol {
    // MARK: - Перечисление для таблицы

    enum ContentType {
        case search
        case filter
        case category
    }

    // MARK: - Public properties

    var presenter: CategoryPresenterProtocol?
    var categories = [
        FoodModel(image: "food1", name: "Simple Fish And Corn", time: "60 min", kkal: "274 kkal"),
        FoodModel(image: "food2", name: "Fast Roast Fish & Show Peas Recipes", time: "80 min", kkal: "94 kkal"),
        FoodModel(image: "food3", name: "Lemon and Chili Fish Fish Burrito", time: "90 min", kkal: "226 kkal"),
        FoodModel(image: "food4", name: "Baked Fish with Lemon Herb Sauce", time: "90 min", kkal: "616 kkal"),
        FoodModel(image: "food5", name: "Salmon with Cantaloupe and Fried Shallots", time: "100 min", kkal: "410 kkal"),
        FoodModel(image: "food6", name: "Chili and Tomato Fish", time: "100 min", kkal: "174 kkal"),
    ]

    // MARK: - Private properties

    private let contents: [ContentType] = [.search, .filter, .category]

    // MARK: - Visual components

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: FilterTableViewCell.identifier)
        tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false

        let leftArrow = UIBarButtonItem(
            image: UIImage(named: "arrow"),
            style: .done,
            target: self,
            action: #selector(arrowPressed)
        )
        leftArrow.tintColor = .black
        let leftTitle = UIBarButtonItem(title: "Fish", image: nil, target: nil, action: nil)
        leftTitle.tintColor = .black
        leftTitle.style = .plain
        navigationItem.leftBarButtonItems = [leftArrow, leftTitle]
    }

    // MARK: - Private methods

    @objc private func arrowPressed() {
        presenter?.moveBack()
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - CategoryViewController + UITableViewDataSource

extension CategoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        contents.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch contents[section] {
        case .search:
            return 1
        case .filter:
            return 1
        case .category:
            return categories.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch contents[indexPath.section] {
        case .search:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: SearchTableViewCell.identifier,
                for: indexPath
            ) as? SearchTableViewCell else { return UITableViewCell() }
            return cell
        case .filter:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: FilterTableViewCell.identifier,
                for: indexPath
            ) as? FilterTableViewCell else { return UITableViewCell() }
            return cell
        case .category:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CategoriesTableViewCell.identifier,
                for: indexPath
            ) as? CategoriesTableViewCell else { return UITableViewCell() }
            cell.configure(model: categories[indexPath.row])
            return cell
        }
    }
}

// MARK: - CategoryViewController + UITableViewDelegate

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section)
        print(indexPath.row)

        if indexPath.section == 2 {
            let data = categories[indexPath.row]
            let recipeDescriptionController = RecipeDescriptionController()
            // модель рецепта в контроллер с рецептом
            let selectedRecipe = categories[indexPath.row]
            recipeDescriptionController.selectedRecipe = selectedRecipe
            //  переход на экран с рецептом
            navigationController?.pushViewController(recipeDescriptionController, animated: true)
        }
    }
}
