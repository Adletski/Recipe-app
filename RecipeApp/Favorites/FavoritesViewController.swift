// FavoritesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol FavoritesViewControllerProtocol: AnyObject {}

final class FavoritesViewController: UIViewController, FavoritesViewControllerProtocol {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        return tableView
    }()

    let emptyView: EmptyView = {
        let view = EmptyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()

    var presenter: FavoritesPresenterProtocol?
    var categories = [
        FoodModel(image: "food1", name: "Simple Fish And Corn", time: "60 min", kkal: "274 kkal"),
        FoodModel(image: "food2", name: "Fast Roast Fish & Show Peas Recipes", time: "80 min", kkal: "94 kkal")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(tableView)
        view.addSubview(emptyView)

        tableView.frame = view.bounds

        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if categories.isEmpty {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
        }
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoriesTableViewCell.identifier,
            for: indexPath
        ) as? CategoriesTableViewCell else { return UITableViewCell() }
        cell.configure(model: categories[indexPath.row])
        return cell
    }
}
