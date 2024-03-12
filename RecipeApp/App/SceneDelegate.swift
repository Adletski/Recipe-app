// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Сцена
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Properties

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    var navigationController: UINavigationController?

    // MARK: - Public methods

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        if let window {
//            window.rootViewController = PracticeViewController()
            window.makeKeyAndVisible()
            appCoordinator = AppCoordinator()
            appCoordinator?.start()
        }
    }
}
