// ProfilePresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для профиля презентера
protocol ProfilePresenter: AnyObject {
    init(view: ProfileView, coordinator: ProfileCoordinator)

    func viewDidLoad()
    func editButtonDidPress()
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

    func showTermsPrivacyPolicy() {
        guard let rootController = profileCoordinator?.rootController else {
            return
        }

        let termsPrivacyPolicyViewController = UIViewController()
        let termsPrivacyPolicyView = TermsPrivacyPolicyView(frame: rootController.view.bounds)

        termsPrivacyPolicyViewController.view.addSubview(termsPrivacyPolicyView)

        termsPrivacyPolicyView.alpha = 0.0
        UIView.animate(withDuration: 0.5, animations: {
            termsPrivacyPolicyView.alpha = 1.0
        })

        rootController.present(termsPrivacyPolicyViewController, animated: true, completion: nil)
    }
}

/*
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
 */
