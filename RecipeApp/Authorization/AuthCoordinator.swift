// AuthCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// координатор авторизации
final class AuthCoordinator: BaseCoordinator {
    var rootController: UINavigationController?
    var onFinishFlow: (() -> ())?

    override func start() {
        showLogin()
    }

    func onFinish() {
        onFinishFlow?()
    }

    func showLogin() {
        let authViewController = AuthorizationViewController()
        let authPresenter = AuthPresenter(view: authViewController)
        authViewController.presenter = authPresenter
        authPresenter.authCoordinator = self

        let rootController = UINavigationController(rootViewController: authViewController)
        setAsRoot(rootController)
        self.rootController = rootController
    }

    func moveToNextScreen() {
        print("coordinator")
        let vc = AuthorizationViewController()
        rootController?.pushViewController(vc, animated: true)
    }
}
