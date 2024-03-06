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
        guard let rootController = profileCoordinator?.rootController else {
            return
        }

        let termsPrivacyPolicyViewController = UIViewController()
        let termsPrivacyPolicyView = TermsPrivacyPolicyView(frame: rootController.view.bounds)
        termsPrivacyPolicyViewController.view.addSubview(termsPrivacyPolicyView)
        termsPrivacyPolicyView.alpha = 0.0

        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            termsPrivacyPolicyView.alpha = 1.0
        }
        animator.startAnimation()

        rootController.present(termsPrivacyPolicyViewController, animated: true, completion: nil)
    }
}
