// FavoritesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол делегата для контроллера экрана избранных.
protocol FavoritesViewControllerProtocol: AnyObject {}
/// Контроллер экрана избранных
final class FavoritesViewController: UIViewController, FavoritesViewControllerProtocol {
    enum Constant {
        static let cell = "cell"
    }

    // MARK: - Constants

    /// Презентер для управления логикой отображения экрана избранных.
    var presenter: FavoritesPresenterProtocol?
    /// Список категорий блюд
    var categories: [Recipe] = []

    // MARK: - Visual Components

    /// Таблица для отображения категорий блюд
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constant.cell)
        tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        return tableView
    }()

    /// Представление для отображения пустого состояния.
    let emptyView: EmptyView = {
        let view = EmptyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = false
        return view
    }()

    // MARK: - Initializers

    /// Настройка и добавление UI-элементов
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

        if let savedData = UserDefaults.standard.object(forKey: "favorites") as? Data {
            do {
                let savedContacts = try JSONDecoder().decode([Recipe].self, from: savedData)
                categories = savedContacts
            } catch {
                print(error.localizedDescription)
            }
        }

        if categories.isEmpty {
            tableView.isHidden = true
            emptyView.isHidden = false
        } else {
            tableView.isHidden = false
            emptyView.isHidden = true
        }

        tableView.reloadData()
    }
}

// MARK: - extension - UITableViewDataSource

/// Расширение для поддержки протокола UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    /// Возвращает количество ячеек в таблице.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }

    /// Предоставляет ячейку для отображения в заданной позиции таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CategoriesTableViewCell.identifier,
            for: indexPath
        ) as? CategoriesTableViewCell else { return UITableViewCell() }
        cell.configure(model: categories[indexPath.row])
        return cell
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            if let savedData = UserDefaults.standard.object(forKey: "favorites") as? Data {
                do {
                    var savedContacts = try JSONDecoder().decode([Recipe].self, from: savedData)

//                    savedContacts.removeAll { $0.name == categories[indexPath.row].name }

                    categories = savedContacts
                } catch {
                    print(error.localizedDescription)
                }
            }
            tableView.reloadData()

            do {
                let encodedData = try JSONEncoder().encode(categories)
                UserDefaults.standard.set(encodedData, forKey: "favorites")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
