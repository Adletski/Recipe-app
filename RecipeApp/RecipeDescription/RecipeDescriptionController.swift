// RecipeDescriptionController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с рецептом
final class RecipeDescriptionController: UIViewController {
    // MARK: - Constants

    enum Details {
        case photo
        case characteristics
        case description
    }

    var selectedRecipe: FoodModel = .fishRecipes[0]

    let range: [Details] = [.photo, .characteristics, .description]

    // MARK: - Visual Components

    private let backBarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow"), for: .normal)
        return button
    }()

    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sendButtonImage"), for: .normal)
        return button
    }()

    private let setFavorite: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "savedButtonImage"), for: .normal)
        return button
    }()

    private let barView = UIView()

    private let tableView = UITableView()

    let recipeCells: [Details] = [.photo, .characteristics, .description]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
    }

    private func setupView() {
        view.backgroundColor = .red
        view.addSubview(tableView)
        setupTableView()
    }

    private func setupNavigationBar() {
        let backButton = UIBarButtonItem(customView: backBarButton)
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
    }
}

extension RecipeDescriptionController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

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
                image: selectedRecipe.image,
                name: selectedRecipe.name,
                title: selectedRecipe.title,
                time: selectedRecipe.time,
                kkal: selectedRecipe.kkal,
                weight: selectedRecipe.weight,
                carbohydrates: selectedRecipe.carbohydrates,
                fats: selectedRecipe.fats,
                proteins: selectedRecipe.proteins,
                descriptions: selectedRecipe.descriptions
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
                kkal: selectedRecipe.kkal,
                carbohydrates: selectedRecipe.carbohydrates,
                fats: selectedRecipe.fats,
                proteins: selectedRecipe.proteins
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
                descriptions: selectedRecipe.descriptions
            ))
            return cell
        }
    }
}

extension RecipeDescriptionController: UITableViewDelegate {
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