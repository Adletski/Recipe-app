// AuthorizationPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Создание презентора для реализации mvp
class AuthorizationPresenter {
    weak var viewController: AuthorizationViewController?
//    var service: Service? database

    init(viewController: AuthorizationViewController) {
        self.viewController = viewController
    }

    // MARK: - Text Field and Keyboard Interaction Methods

    func validateEmail(email: String) {
        if email.isEmpty {
            viewController?.updateValidationEmail(result: "isEmpty")
        } else if email.isEmpty || !email.contains("@mail.ru") {
            viewController?.updateValidationEmail(result: "noEmail")
        } else {
            viewController?.updateValidationEmail(result: "good")
        }
    }

    func validatePassword(password: String) {
//        guard let viewController = viewController,
//              let password = viewController.passwordTextField.text else { return }
//
//        if password.isEmpty {
//            viewController.passwordTextField.layer.borderColor = UIColor.clear.cgColor
//            viewController.passwordTextField.layer.borderWidth = 0.0
//            viewController.warningPassLabel.isHidden = true
//        } else if password.lowercased() != "qwerty12345" {
//            viewController.passwordLabel.textColor = .red
//            viewController.passwordTextField.layer.borderColor = UIColor.red.cgColor
//            viewController.passwordTextField.layer.borderWidth = 1.0
//            viewController.passwordTextField.layer.cornerRadius = 8
//            viewController.warningPassLabel.isHidden = false
//        } else {
//            viewController.passwordLabel.textColor = UIColor(named: "loginColor")
//            viewController.passwordTextField.layer.borderColor = UIColor.clear.cgColor
//            viewController.passwordTextField.layer.borderWidth = 0.0
//            viewController.warningPassLabel.isHidden = true
//        }
    }

    func loginButtonTapped(login: String, password: String) {
        if login == "1234", password == "1234" {
            viewController?.chekIt(true)
        } else {
            viewController?.chekIt(false)
        }

        /* guard let viewController = viewController else { return }

         viewController.loginButton.setTitle("", for: .normal)
         let activityIndicator = UIActivityIndicatorView(style: .medium)
         activityIndicator.color = .white
         activityIndicator.center = CGPoint(
             x: viewController.loginButton.bounds.midX,
             y: viewController.loginButton.bounds.midY
         )
         activityIndicator.startAnimating()
         viewController.loginButton.addSubview(activityIndicator)

         Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
             activityIndicator.stopAnimating()
             activityIndicator.removeFromSuperview()
             self.showErrorPanel()
         } */
    }

//    private func showErrorPanel() {
//        guard let viewController = viewController else { return }
//
//        viewController.view.addSubview(viewController.errorView)
//        viewController.makeErrorViewConstraint()
//        viewController.errorView.addSubview(viewController.errorMessageLabel)
//        viewController.makeErrorMessageLabel()
//    }
}
