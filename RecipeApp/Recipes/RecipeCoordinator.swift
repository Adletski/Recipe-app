//
//  RecipeCoordinator.swift
//  RecipeApp
//
//  Created by Adlet Zhantassov on 28.02.2024.
//

import UIKit

final class RecipeCoordinator: BaseCoordinator {
    var rootController: UINavigationController
    var onFinishFlow: (() -> ())?
    
    init(rootController: UIViewController) {
        self.rootController = UINavigationController(rootViewController: rootController)
    }
}
