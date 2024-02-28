// RecipeCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class RecipeCoordinator: BaseCoordinator {
    var rootController: UINavigationController
    var onFinishFlow: (() -> ())?

    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }
}
