// RecipeDescriptionController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с рецептом
final class RecipeDescriptionController: UIViewController {
    // MARK: - Constants

    enum Constant {
        static let arrowImage = "arrow"
        static let sendButtonImage = "sendButtonImage"
        static let savedButtonImage = "savedButtonImage"
    }

    /// Перечисление для  деталей рецепта
    enum Details {
        /// фото
        case photo
        /// характеристики
        case characteristics
        /// описание
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
        let setFavoriteBarButton = UIBarButtonItem(customView: setFavorite)
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

    // MARK: - IBAction

    @objc private func backButtonPressed() {
        presenter?.moveBack()
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
            cell.configure(recipe: FoodModel(
                image: selectedRecipe?.image ?? "",
                name: selectedRecipe?.name ?? "",
                title: selectedRecipe?.title ?? "",
                time: selectedRecipe?.time ?? "",
                timeCount: selectedRecipe?.timeCount ?? 0,
                kkal: selectedRecipe?.kkal ?? "",
                kkalCount: selectedRecipe?.kkalCount ?? 0,
                weight: selectedRecipe?.weight,
                carbohydrates: selectedRecipe?.carbohydrates,
                fats: selectedRecipe?.fats,
                proteins: selectedRecipe?.proteins,
                descriptions: selectedRecipe?.descriptions
            ))
            return cell
        case .characteristics:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecipeECFPCell.identifier,
                for: indexPath
            ) as? RecipeECFPCell else {
                return UITableViewCell()
            }
            cell.configure(recipe: FoodModel(
                timeCount: selectedRecipe?.timeCount ?? 0, kkal: selectedRecipe?.kkal ?? "",
                kkalCount: selectedRecipe?.kkalCount ?? 0,
                carbohydrates: selectedRecipe?.carbohydrates,
                fats: selectedRecipe?.fats,
                proteins: selectedRecipe?.proteins
            ))
            return cell
        case .description:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RecipeTextCell.identifier,
                for: indexPath
            ) as? RecipeTextCell else {
                return UITableViewCell()
            }
            cell.configure(recipe: FoodModel(
                descriptions: selectedRecipe?.descriptions
            ))
            return cell
        }
    }
}

extension RecipeDescriptionController: UITableViewDelegate {
    // Возвращает высоту строки для ячейки по указанному индекy
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
