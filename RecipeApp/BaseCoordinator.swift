// BaseCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Это базовый координатор который будет как будто протокол
class BaseCoordinator {
    var childCoordinators: [BaseCoordinator] = []

    // MARK: - Public Methods
    /// Метод запуска координатора
    func start() {
        fatalError("child должен быть реализован")
    }
    /// Добавление дочернего координатора
    func add(coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }
    /// Удаление дочернего координатора
    func remove(coordinator: BaseCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
    /// Установка контроллера в качестве корневого контроллера приложения
    func setAsRoot(_ controller: UIViewController) {
        let window = UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .last { $0.isKeyWindow }
        window?.rootViewController = controller
    }
}
