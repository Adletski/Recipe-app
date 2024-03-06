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
        add(coordinator: recipeCoordinator)

        // favorites
        let favoritesCoordinator = FavoritesCoordinator()
        let favoritesModuleView = FavoritesBuilder.createFavorites(coordinator: favoritesCoordinator)
        favoritesCoordinator.setupRootController(viewController: favoritesModuleView)
        add(coordinator: favoritesCoordinator)

        // profile
        let profileCoordinator = ProfileCoordinator()
        let profileModuleView = ProfileBuilder.createProfile(coordinator: profileCoordinator)
        profileCoordinator.setupRootController(viewController: profileModuleView)
        add(coordinator: profileCoordinator)

        guard let recipeRootController = recipeCoordinator.rootController,
              let profileRootController = profileCoordinator.rootController,
              let favoritesRootController = favoritesCoordinator.rootController else { return }

        tabBarViewController?.setViewControllers([
            recipeRootController,
            favoritesRootController,
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
