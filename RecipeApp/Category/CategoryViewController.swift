// CategoryViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для категорий еды
protocol CategoryViewControllerProtocol: AnyObject {
    /// Обновляет таблицу с учетом количества калорий в блюдах
    func updateView()
    func updateSearchBar()
}

/// Экран для категорий еды
final class CategoryViewController: UIViewController, CategoryViewControllerProtocol {
    enum Constant {
        static let skeleton = "skeleton"
        static let calories = "calories"
        static let time = "time"
        static let arrow = "arrow"
        static let fish = "Fish"
    }

    // MARK: - Public properties

    /// презентер экрана категорий еды
    var presenter: CategoryPresenterProtocol?
    /// производится ли поиск в данный момент
    private var isShowSkeleton = false

    // MARK: - Visual components

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.identifier)
        tableView.register(SkeletonTableViewCell.self, forCellReuseIdentifier: Constant.skeleton)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        return searchBar
    }()

    private lazy var sortingControlView: SortingViewControl = {
        let sortingView = SortingViewControl()
        sortingView.translatesAutoresizingMaskIntoConstraints = false
        sortingView.delegate = self
        sortingView.dataSource = self
        return sortingView
    }()

    private let names = [Constant.calories, Constant.time]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoaded()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    // MARK: - Private methods

    /// Обработчик нажатия на кнопку "назад"
    @objc private func arrowPressed() {
        presenter?.moveBack()
    }

    /// Обновляет таблицу с учетом количества калорий в блюдах
    func updateView() {
        tableView.reloadData()
    }

    func updateSearchBar() {
        searchBar.text = ""
        searchBar.endEditing(true)
        tableView.reloadData()
    }
}

extension CategoryViewController: SortingViewControlDelegate, SortingPickerDataSource {
    func onButtonPressed(state: ButtonState) {
        presenter?.filterButtonPressed(state: state)
    }

    func sortPickerCount(_ dayPicker: SortingViewControl) -> Int {
        names.count
    }

    func sortPickerTitle(_ dayPicker: SortingViewControl, indexPath: IndexPath) -> String {
        names[indexPath.row]
    }
}

// MARK: - CategoryViewController + UISearchBarDelegate

extension CategoryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchBarDelegate(searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.cancelButtonPressed()
    }
}

// MARK: - CategoryViewController + UITableViewDataSource

extension CategoryViewController: UITableViewDataSource {
    /// Возвращает количество секций в таблице
    func numberOfSections(in tableView: UITableView) -> Int {
        if isShowSkeleton {
            return 1
        } else {
            return 1
        }
    }

    /// Возвращает количество строк в указанной секции таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isShowSkeleton {
            return 1
        } else {
            if presenter?.isSearching ?? false {
                return presenter?.searchingCategories.count ?? 0
            } else {
                return presenter?.categories.count ?? 0
            }
        }
    }

    /// Возвращает ячейку для указанного индекса
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isShowSkeleton {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constant.skeleton,
                for: indexPath
            ) as? SkeletonTableViewCell else { return UITableViewCell() }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CategoriesTableViewCell.identifier,
                for: indexPath
            ) as? CategoriesTableViewCell else { return UITableViewCell() }
            if presenter?.isSearching ?? false {
                if let food = presenter?.searchingCategories[indexPath.row] {
                    cell.configure(model: food)
                }
            } else {
                if let food = presenter?.categories[indexPath.row] {
                    cell.configure(model: food)
                }
            }
            return cell
        }
    }
}

// MARK: - CategoryViewController + UITableViewDelegate

/// расширение для UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {
    /// Вызывается при выборе ячейки таблицы
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = presenter?.categories[indexPath.row]
        // модель рецепта в контроллер с рецептом
        if let selectedRecipe {
            //  переход на экран с рецептом
            presenter?.openRecipeDescriptionVC(model: selectedRecipe)
        }
    }
}

// MARK: - CategoryViewController

extension CategoryViewController {
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        let leftArrow = UIBarButtonItem(
            image: UIImage(named: Constant.arrow),
            style: .done,
            target: self,
            action: #selector(arrowPressed)
        )
        leftArrow.tintColor = .black
        let leftTitle = UIBarButtonItem(title: Constant.fish, image: nil, target: nil, action: nil)
        leftTitle.tintColor = .black
        leftTitle.style = .plain
        leftTitle.setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .bold)],
            for: .normal
        )
        navigationItem.leftBarButtonItems = [leftArrow, leftTitle]
    }

    /// Настройка пользовательского интерфейса
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(sortingControlView)
        view.addSubview(tableView)

        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        sortingControlView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5).isActive = true
        sortingControlView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        sortingControlView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sortingControlView.widthAnchor.constraint(equalToConstant: 230).isActive = true

        tableView.topAnchor.constraint(equalTo: sortingControlView.bottomAnchor, constant: 5).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
