// RecipesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для вью рецептов
protocol RecipesView: AnyObject {
    var presenter: RecipesViewPresenterProtocol? { get set }
}

// MARK: - Visual Components

/// Экран для рецептов
final class RecipesViewController: UIViewController { // }, RecipesView {
    // var presenter: RecipesPresenterProtocol?
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    var presenter: RecipesViewPresenterProtocol?

    // MARK: - Private Properties

    private let reuseIdentifier = "RecipesCustomCell"

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Recipes"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(collectionView)
        setupCollectionView()
        setupConstraints()
    }

    // MARK: - Private Methods

    /// Настройка коллекции для отображения рецептов
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RecipesCustomCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    /// Настройка ограничений для коллекции
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - Extensions

/// расширение для UICollectionViewDataSource
extension RecipesViewController: UICollectionViewDataSource {
    /// количество элементов в секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.getCategoryCount() ?? 0
    }

    /// создание и настройка ячейки
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let category = presenter?.getInfo(categoryNumber: indexPath.item)
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? RecipesCustomCell
        else {
            return UICollectionViewCell()
        }
        cell.setInfo(info: category ?? DishCategory(imageName: "", type: .chicken))
        return cell
    }
}

/// Расширение для UICollectionViewDelegateFlowLayout
extension RecipesViewController: UICollectionViewDelegateFlowLayout {
    /// Определение размера ячейки
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        var cellSize = CGFloat()
        let cellNumber = indexPath.item % 7

        switch cellNumber {
        case 0, 1:
            cellSize = (view.frame.width - 30) / 2
        case 2, 6:
            cellSize = view.frame.width - 140
        case 3 ... 5:
            cellSize = (view.frame.width - 40) / 3
        default:
            cellSize = 10
        }
        return CGSize(width: cellSize, height: cellSize)
    }

    /// Определение внутренних отступов секции коллекции
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    /// Определение минимального расстояния между строками в секции коллекции
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        10
    }

    /// Определение минимального расстояния между ячейками в строке секции коллекции
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        9
    }

    /// Обработка нажатия на ячейку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.goToCategory(.fish)
    }
}

/// расширенеи для реализации протокола RecipesView
extension RecipesViewController: RecipesView {}
