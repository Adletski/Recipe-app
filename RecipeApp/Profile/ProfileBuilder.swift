// ProfileBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Билд для профиля модуля
final class ProfileBuilder {
    static func createProfile() -> UIViewController {
        let viewController = ProfileViewController()
        viewController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(named: "profile"),
            selectedImage: UIImage(named: "profileFilled")
        )
        viewController.presenter = ProfilePresenterImpl()
        viewController.presenter?.view = viewController
        return viewController
    }
}
