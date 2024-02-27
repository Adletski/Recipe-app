// AuthPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

final class AuthPresenter {
    weak var view: AuthorizationViewController?
    weak var authCoordinator: AuthCoordinator?

    init(view: AuthorizationViewController) {
        self.view = view
    }

    func nextButtonPressed() {
        authCoordinator?.moveToNextScreen()
    }
}
