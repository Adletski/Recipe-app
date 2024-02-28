// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для профиля презентера
protocol ProfilePresenter: AnyObject {
    var view: ProfileView! { get set }

    func viewDidLoad()
    func editButtonDidPress()
}

/// Презентер профиля
final class ProfilePresenterImpl: ProfilePresenter {
    // MARK: - Properties

    weak var view: ProfileView!

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
