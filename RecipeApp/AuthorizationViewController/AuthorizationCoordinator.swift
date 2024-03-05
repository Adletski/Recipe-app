// AuthorizationCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Координатор навигации для экрана авторизации
final class AuthorizationCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var rootController: UINavigationController?
    var onFinishFlow: (() -> ())?

    // MARK: - Public methods

    override func start() {
        let authViewController = AuthorizationViewController()
        let authPresenter = AuthorizationPresenter(view: authViewController, coordinator: self)
        authViewController.presenter = authPresenter
        let rootController = UINavigationController(rootViewController: authViewController)
        setAsRoot(rootController)
        self.rootController = rootController
    }

    // MARK: - Public Methods

    func finish() {
        onFinishFlow?()
    }
}
