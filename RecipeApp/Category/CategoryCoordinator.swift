// CategoryCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор для категорий
final class CategoryCoordinator: BaseCoordinator {
    // MARK: - Properties
    var rootController: UIViewController?

    // MARK: - Lifecycle
    override func start() {
        let categoryViewController = CategoryViewController()
        let categoryPresenter = CategoryPresenter(view: categoryViewController, coordinator: self)
        categoryViewController.presenter = categoryPresenter
        rootController = categoryViewController
    }
    
    // MARK: - Public methods
    func moveBack() {
        rootController?.navigationController?.popViewController(animated: true)
    }
}
