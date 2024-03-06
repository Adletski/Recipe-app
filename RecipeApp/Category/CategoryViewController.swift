// CategoryViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для категорий еды
protocol CategoryViewControllerProtocol: AnyObject {
    /// Обновляет таблицу с учетом количества калорий в блюдах
    func updateView()
    /// Обновляет состояние текстового поля поиска
    func updateTextFieldSearching(_ bool: Bool)
    func showSkeleton()
    func offSkeleton()
}

/// Экран для категорий еды
final class CategoryViewController: UIViewController, CategoryViewControllerProtocol {
    // MARK: - Перечисление для таблицы

    /// типы контента в таблице
    enum ContentType {
        /// поиск
        case search
        /// фильтр
        case filter
        /// категории
        case category
    }

    // MARK: - Public properties

    /// презентер экрана категорий еды
    var presenter: CategoryPresenterProtocol?
    /// производится ли поиск в данный момент
    private var isSearching = false
    private var isShowSkeleton = false

    // MARK: - Private properties

    /// Типы содержимого таблицы
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
        tableView.register(SkeletonTableViewCell.self, forCellReuseIdentifier: "skeleton")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoaded()
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
        leftTitle.setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .bold)],
            for: .normal
        )
        navigationItem.leftBarButtonItems = [leftArrow, leftTitle]
    }

    // MARK: - Private methods

    /// Обработчик нажатия на кнопку "назад"
    @objc private func arrowPressed() {
        presenter?.moveBack()
    }

    /// Настройка пользовательского интерфейса
    private func setupUI() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    /// Обновляет таблицу с учетом количества калорий в блюдах
    func updateView() {
        tableView.reloadData()
    }

    /// Обновляет состояние текстового поля поиска
    func updateTextFieldSearching(_ bool: Bool) {
        isSearching = bool
        tableView.reloadData()
    }

    /// Показывает шиммер
    func showSkeleton() {
        isShowSkeleton = true
        tableView.reloadData()
    }

    /// Прячет шиммер
    func offSkeleton() {
        isShowSkeleton = false
        tableView.reloadData()
    }
}

// MARK: - CategoryViewController + UITableViewDataSource

extension CategoryViewController: UITableViewDataSource {
    /// Возвращает количество секций в таблице
    func numberOfSections(in tableView: UITableView) -> Int {
        if isShowSkeleton {
            return 1
        } else {
            return contents.count
        }
    }

    /// Возвращает количество строк в указанной секции таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isShowSkeleton {
            return 1
        } else {
            switch contents[section] {
            case .search:
                return 1
            case .filter:
                return 1
            case .category:
                if isSearching {
                    return presenter?.searchingCategories.count ?? 0
                } else {
                    return presenter?.categories.count ?? 0
                }
            }
        }
    }

    /// Возвращает ячейку для указанного индекса
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isShowSkeleton {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "skeleton",
                for: indexPath
            ) as? SkeletonTableViewCell else { return UITableViewCell() }
            return cell
        } else {
            switch contents[indexPath.section] {
            case .search:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchTableViewCell.identifier,
                    for: indexPath
                ) as? SearchTableViewCell else { return UITableViewCell() }
                cell.delegate = self
                return cell
            case .filter:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: FilterTableViewCell.identifier,
                    for: indexPath
                ) as? FilterTableViewCell else { return UITableViewCell() }
                cell.delegate = self
                return cell
            case .category:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: CategoriesTableViewCell.identifier,
                    for: indexPath
                ) as? CategoriesTableViewCell else { return UITableViewCell() }
                if isSearching {
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
}

// MARK: - CategoryViewController + UITableViewDelegate

/// расширение для UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {
    /// Вызывается при выборе ячейки таблицы
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let selectedRecipe = presenter?.categories[indexPath.row]
            // модель рецепта в контроллер с рецептом
            if let selectedRecipe {
                //  переход на экран с рецептом
                presenter?.openRecipeDescriptionVC(model: selectedRecipe)
            }
        }
    }
}

/// расширение для FilterTableViewCellDelegate
extension CategoryViewController: FilterTableViewCellDelegate {
    /// Обрабатывает нажатие кнопки калорий
    func onButtonPressed(state: ButtonState) {
        presenter?.sortingButtonPressed(state)
    }
}

/// Расширение для SearchTableViewCellDelegate
extension CategoryViewController: SearchTableViewCellDelegate {
    /// Обрабатывает нажатие текстового поля поиска
    func textFieldTapped(_ text: String) {
        presenter?.textFieldTapped(text)
    }
}
