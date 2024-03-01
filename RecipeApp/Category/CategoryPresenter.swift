// CategoryPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера экрана категорий
protocol CategoryPresenterProtocol: AnyObject {
    /// Координатор флоу экрана
    var coordinator: CategoryCoordinator? { get set }
    /// Инициализатор с присвоением вью
    init(view: CategoryViewControllerProtocol, coordinator: CategoryCoordinator)
    /// Выход назад
    func moveBack()
}

final class CategoryPresenter: CategoryPresenterProtocol {
    // MARK: - Public Properties

    weak var view: CategoryViewControllerProtocol?
    var coordinator: CategoryCoordinator?

    // MARK: - Initializers

    init(view: CategoryViewControllerProtocol, coordinator: CategoryCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }

    // MARK: - Public methods

    func moveBack() {
        coordinator?.moveBack()
    }
}
