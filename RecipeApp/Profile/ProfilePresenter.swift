// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для профиля презентера
protocol ProfilePresenter: AnyObject {
    init(view: ProfileView, coordinator: ProfileCoordinator)

    func viewDidLoad()
    func editButtonDidPress()
}

/// Презентер профиля
final class ProfilePresenterImpl: ProfilePresenter {
    // MARK: - Properties

    weak var profileCoordinator: ProfileCoordinator?
    weak var view: ProfileView?

    init(view: ProfileView, coordinator: ProfileCoordinator) {
        self.view = view
        profileCoordinator = coordinator
    }

    // MARK: - Public methods

    func viewDidLoad() {
        view?.updateView(model: ProfileModel(
            name: "Adlet",
            surname: "Zhantassov",
            profileImageView: "avatar",
            categories: ["Bonuses", "Terms & Privacy policy", "Log out"]
        ))
    }

    func editButtonDidPress() {}
}
