// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для профиля презентера
protocol ProfilePresenter: AnyObject {
    init(view: ProfileView, coordinator: ProfileCoordinator)

    /// Метод вызывается при загрузке представления
    func viewDidLoad()
    /// Метод вызывается при нажатии кнопки редактирования
    func editButtonDidPress()
    /// Метод для отображения экрана условий и политики конфиденциальности
    func showTermsPrivacyPolicy()
}

/// Презентер профиля
final class ProfilePresenterImpl: ProfilePresenter {
    var profileCoordinator: ProfileCoordinator?
    init(view: ProfileView, coordinator: ProfileCoordinator) {
        self.view = view as? ProfileViewController
        profileCoordinator = coordinator
    }

    // MARK: - Properties

    // weak var profileCoordinator: ProfileCoordinator?
    var view: ProfileViewController?

    init(view: ProfileViewController, coordinator: ProfileCoordinator) {
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
    /// Метод для отображения экрана условий и политики конфиденциальности
    func showTermsPrivacyPolicy() {
        view?.showTermsPrivacyPolicy()
    }
}
