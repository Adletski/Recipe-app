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
    // MARK: - Constants

    enum Constants {
        static let name = "Adlet"
        static let surname = "Zhantassov"
        static let avatar = "avatar"
        static let bonuses = "Bonuses"
        static let privacy = "Terms & Privacy policy"
        static let log = "Log out"
    }

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
            name: Constants.name,
            surname: Constants.surname,
            profileImageView: Constants.avatar,
            categories: [Constants.bonuses, Constants.privacy, Constants.log]
        ))
    }

    func editButtonDidPress() {}
    /// Метод для отображения экрана условий и политики конфиденциальности
    func showTermsPrivacyPolicy() {
        view?.showTermsPrivacyPolicy()
    }
}
