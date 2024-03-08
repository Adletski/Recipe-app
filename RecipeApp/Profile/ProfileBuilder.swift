// ProfileBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Билд для профиля модуля
final class ProfileBuilder {
    // MARK: - Constants

    enum Constant {
        static let title = "Profile"
        static let profile = "profile"
        static let profileFilled = "profileFilled"
    }

    // MARK: - Public Methods

    static func createProfile(coordinator: ProfileCoordinator) -> ProfileViewController {
        let navigationController = coordinator.setupNavigationController()
        let viewController = ProfileViewController()
        let profilePresenter = ProfilePresenterImpl(view: viewController, coordinator: coordinator)
        viewController.presenter = profilePresenter
        navigationController.viewControllers = [viewController]
        viewController.tabBarItem = UITabBarItem(
            title: Constant.title,
            image: UIImage(named: Constant.profile),
            selectedImage: UIImage(named: Constant.profileFilled)
        )
        return viewController
    }
}
