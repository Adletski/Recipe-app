// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// координатор главный приложения
final class AppCoordinator: BaseCoordinator {
    private var tabBarViewController: TabBarViewController?

    override func start() {
        if "admin" == "admin" {
            toMain()
        } else {
            toAuth()
        }
    }

    private func toMain() {
        tabBarViewController = TabBarViewController()

        // recipe
        let recipeCoordinator = RecipeCoordinator()
        let recipeModuleView = RecipesBuilder.createRecipe(coordinator: recipeCoordinator)
        recipeCoordinator.setRootController(viewController: recipeModuleView)
        recipeModuleView.title = "Recipes"
        recipeModuleView.navigationController?.navigationBar.prefersLargeTitles = true
        add(coordinator: recipeCoordinator)

        // profile
        let profileCoordinator = ProfileCoordinator()
        let profileModuleView = ProfileBuilder.createProfile(coordinator: profileCoordinator)
        profileCoordinator.setupRootController(viewController: profileModuleView)
        profileModuleView.title = "Profile"
        profileModuleView.navigationController?.navigationBar.prefersLargeTitles = true
        add(coordinator: profileCoordinator)

        guard let recipeRootController = recipeCoordinator.rootController else { return }
        guard let profileRootController = profileCoordinator.rootController else { return }

        tabBarViewController?.setViewControllers([
            recipeRootController,
            profileRootController
        ], animated: true)

        if let tabBarViewController {
            setAsRoot(tabBarViewController)
        }
    }

    private func toAuth() {
        let authCoordinator = AuthorizationCoordinator()
        authCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: authCoordinator)
            self?.toMain()
        }
        add(coordinator: authCoordinator)
        authCoordinator.start()
    }
}
