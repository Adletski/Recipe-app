// CategoryViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для категорий еды
protocol CategoryViewControllerProtocol: AnyObject {
    /// Обновляет таблицу с учетом количества калорий в блюдах
    func updateView()
    func updateSearchBar()
    func success()
    func failure()
    func updateRecipes(_ recipes: [Recipe])
    func updateState()
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

    // MARK: - Visual components

    private lazy var leftArrowBarButtonItem: UIBarButtonItem = {
        let leftArrowBarButtonItem = UIBarButtonItem(
            image: UIImage(named: Constant.arrow),
            style: .done,
            target: self,
            action: #selector(arrowPressed)
        )
        leftArrowBarButtonItem.tintColor = .black
        return leftArrowBarButtonItem
    }()

    private lazy var leftTitleBarButtonItem: UIBarButtonItem = {
        let leftTitleBarButtonItem = UIBarButtonItem(title: Constant.fish, image: nil, target: nil, action: nil)
        leftTitleBarButtonItem.tintColor = .black
        leftTitleBarButtonItem.style = .plain
        leftTitleBarButtonItem.setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .bold)],
            for: .normal
        )
        return leftTitleBarButtonItem
    }()

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

    private let noDataView = NoDataView()
    private let failedDownloadDataView = FailedDownloadDataView()

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
        leftTitleBarButtonItem.title = presenter?.category.rawValue
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

    func success() {}

    func failure() {}

    func updateState() {
        tableView.reloadData()
    }
}

extension CategoryViewController: SortingViewControlDelegate, SortingPickerDataSource {
    func onButtonPressed(state: ButtonState) {
        presenter?.isSearching = false
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
        1
    }

    /// Возвращает количество строк в указанной секции таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch presenter?.state {
        case .loading:
            return 1
        case let .data(recipes):
            return recipes.count
        case .noData, .error, .none:
            return 1
        }
    }

    /// Возвращает ячейку для указанного индекса
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.isHidden = false
        switch presenter?.state {
        case .loading:
            failedDownloadDataView.isHidden = true
            noDataView.isHidden = true
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: Constant.skeleton,
                for: indexPath
            ) as? SkeletonTableViewCell else { return UITableViewCell() }
            return cell
        case let .data(recipes):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CategoriesTableViewCell.identifier,
                for: indexPath
            ) as? CategoriesTableViewCell else { return UITableViewCell() }
            cell.configure(model: recipes[indexPath.row])
            if let urlString = URL(string: recipes[indexPath.row].image) {
                presenter?.networkService.proxy.loadImage(
                    name: recipes[indexPath.row].uri,
                    url: urlString,
                    completion: { data, _, _ in
                        guard let data = data else { return }
                        DispatchQueue.main.async {
                            cell.configure(data: data)
                        }
                    }
                )
            }
            return cell
        case .noData:
            tableView.isHidden = true
            noDataView.isHidden = false
        case .error:
            tableView.isHidden = true
            failedDownloadDataView.isHidden = false
        case .none:
            break
        }
        return UITableViewCell()
    }
}

// MARK: - CategoryViewController + UITableViewDelegate

/// расширение для UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {
    /// Вызывается при выборе ячейки таблицы
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = presenter?.recipes[indexPath.row]
        // модель рецепта в контроллер с рецептом
        if let selectedRecipe {
            presenter?.openRecipeDescriptionVC(uri: selectedRecipe.uri)
        }
    }
}

// MARK: - CategoryViewController

extension CategoryViewController {
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItems = [leftArrowBarButtonItem, leftTitleBarButtonItem]
    }

    /// Настройка пользовательского интерфейса
    private func setupUI() {
        failedDownloadDataView.delegate = self
        failedDownloadDataView.isHidden = true
        noDataView.isHidden = true

        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(sortingControlView)
        view.addSubview(tableView)
        view.addSubview(noDataView)
        view.addSubview(failedDownloadDataView)
        setupRefreshControl()

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

        noDataView.topAnchor.constraint(equalTo: sortingControlView.bottomAnchor).isActive = true
        noDataView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        noDataView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        noDataView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        failedDownloadDataView.topAnchor.constraint(equalTo: sortingControlView.bottomAnchor).isActive = true
        failedDownloadDataView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        failedDownloadDataView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        failedDownloadDataView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension CategoryViewController {
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    // @objc private func refreshData(_ sender: Any) {
    //  presenter?.getRecipes(category: .fish)
    // }
    /*@objc private func refreshData(_ sender: Any) {
         guard let currentCategory = presenter?.category else { return }
         presenter?.getRecipes(category: currentCategory)
     }

     func updateRecipes(_ recipes: [Recipe]) {
         presenter?.recipes = recipes
         tableView.reloadData()
     } */
    @objc private func refreshData(_ sender: Any) {
        presenter?.getRecipes(category: .fish)
    }

    func updateRecipes(_ recipes: [Recipe]) {
        presenter?.recipes = recipes
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
}

extension CategoryViewController: FailedDownloadDataViewDelegate {
    func reloadButtonPressed() {
        presenter?.reloadButtonPressed()
    }
}
