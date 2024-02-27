// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class AppBuilder {
    func makeRecipeModule() -> RecipesViewController {
        RecipesViewController()
    }

    func makeFavoritesModule() -> FavoritesViewController {
        FavoritesViewController()
    }

    func makeProfileModule() -> ProfileViewController {
        ProfileViewController()
    }
}

/// координатор главный приложения
final class AppCoordinator: BaseCoordinator {
    private var tabBarViewController: TabBarViewController?
    private var appBuilder = AppBuilder()

    override func start() {
        if "admin" != "admin" {
            toMain()
        } else {
            toAuth()
        }
    }

    private func toMain() {
        tabBarViewController = TabBarViewController()
        
        //recipe
        let recipeModuleView = RecipesBuilder.createRecipe()
        let recipeCoordinator = RecipeCoordinator(rootController: recipeModuleView)
        recipeModuleView.presenter?.coordinator = recipeCoordinator
    }

    private func toAuth() {
        let authCoordinator = AuthCoordinator()
        authCoordinator.onFinishFlow = { [weak self] in
            self?.remove(coordinator: authCoordinator)
            self?.toMain()
        }
        add(coordinator: authCoordinator)
        authCoordinator.start()
    }
}
