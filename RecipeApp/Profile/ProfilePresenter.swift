// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol ProfilePresenter: AnyObject {
    var view: ProfileView! { get set }
    var coordinator: Coordinator! { get set }

    func viewDidLoad()
    func editButtonDidPress()
}

final class ProfilePresenterImpl: ProfilePresenter {
    weak var view: ProfileView!
    weak var coordinator: Coordinator!

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
