// ProfileBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Билд для профиля модуля
final class ProfileBuilder {
    static func createProfile(coordinator: ProfileCoordinator) -> ProfileViewController {
        let navigationController = coordinator.setupNavigationController()
        let viewController = ProfileViewController()
        let profilePresenter = ProfilePresenterImpl(view: viewController, coordinator: coordinator)
        viewController.presenter = profilePresenter
        navigationController.viewControllers = [viewController]
        viewController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(named: "profile"),
            selectedImage: UIImage(named: "profileFilled")
        )
        return viewController
    }
}
