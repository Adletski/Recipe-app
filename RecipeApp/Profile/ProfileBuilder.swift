// ProfileBuilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class ProfileBuilder {
    static func createProfile(coordinator: Coordinator) -> UIViewController {
        let viewController = ProfileViewController()
        viewController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(named: "profile"),
            selectedImage: UIImage(named: "profileFilled")
        )
        viewController.presenter = ProfilePresenterImpl()
        viewController.presenter?.coordinator = coordinator
        viewController.presenter?.view = viewController
        return viewController
    }
}
