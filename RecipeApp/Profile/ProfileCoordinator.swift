// ProfileCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Координатор для профиля
final class ProfileCoordinator: BaseCoordinator {
    // MARK: - Properties

    var rootController: UINavigationController?
    var onFinishFlow: (() -> ())?

    // MARK: - Initializer

    func setupRootController(viewController: UIViewController) {
        rootController = UINavigationController(rootViewController: viewController)
    }

    func setupNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        return navigationController
    }
}
