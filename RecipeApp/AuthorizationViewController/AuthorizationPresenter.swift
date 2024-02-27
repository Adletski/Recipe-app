// AuthorizationPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Создание презентора для реализации mvp
class AuthorizationPresenter {
    weak var viewController: AuthorizationViewController?

    init(viewController: AuthorizationViewController) {
        self.viewController = viewController
    }

    func setupGradientBackground() {
        guard let viewController = viewController else { return }
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = viewController.view.bounds
        gradientLayer.colors = [
            UIColor.white.cgColor,
            UIColor(red: 141 / 255, green: 218 / 255, blue: 247 / 255, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        viewController.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    func setupUI() {
        guard let viewController = viewController else { return }

        viewController.makeLabelLoginConstraints()
        viewController.makeEmailLabelConstraints()
        viewController.makeEmailTextFieldConstraints()
        viewController.makePasswordLabelConstraints()
        viewController.makePasswordTextFieldConstraints()
        viewController.makeLoginButtonConstraints()
        viewController.makeWarbibgLabelConstraints()
        viewController.makeWarningLabelPassConstraints()
        viewController.validateEmail()
        viewController.validatePassword()
        viewController.emailTextField.delegate = viewController
        viewController.passwordTextField.delegate = viewController
        viewController.setupInputAccessoryView()
    }

    // MARK: - Text Field and Keyboard Interaction Methods

    func validateEmail() {
        guard let viewController = viewController, let email = viewController.emailTextField.text else { return }

        if email.isEmpty {
            viewController.emailTextField.layer.borderColor = UIColor.clear.cgColor
            viewController.emailTextField.layer.borderWidth = 0.0
            viewController.warningEmailLabel.isHidden = true
        } else if email.isEmpty || !email.contains("@mail.ru") {
            viewController.emailLabel.textColor = .red
            viewController.emailTextField.layer.borderColor = UIColor.red.cgColor
            viewController.emailTextField.layer.borderWidth = 1.0
            viewController.emailTextField.layer.cornerRadius = 8
            viewController.warningEmailLabel.isHidden = false
        } else {
            viewController.emailLabel.textColor = UIColor(named: "loginColor")
            viewController.emailTextField.layer.borderColor = UIColor.clear.cgColor
            viewController.emailTextField.layer.borderWidth = 0.0
            viewController.warningEmailLabel.isHidden = true
        }
    }

    func validatePassword() {
        guard let viewController = viewController,
              let password = viewController.passwordTextField.text else { return }

        if password.isEmpty {
            viewController.passwordTextField.layer.borderColor = UIColor.clear.cgColor
            viewController.passwordTextField.layer.borderWidth = 0.0
            viewController.warningPassLabel.isHidden = true
        } else if password.lowercased() != "qwerty12345" {
            viewController.passwordLabel.textColor = .red
            viewController.passwordTextField.layer.borderColor = UIColor.red.cgColor
            viewController.passwordTextField.layer.borderWidth = 1.0
            viewController.passwordTextField.layer.cornerRadius = 8
            viewController.warningPassLabel.isHidden = false
        } else {
            viewController.passwordLabel.textColor = UIColor(named: "loginColor")
            viewController.passwordTextField.layer.borderColor = UIColor.clear.cgColor
            viewController.passwordTextField.layer.borderWidth = 0.0
            viewController.warningPassLabel.isHidden = true
        }
    }

    @objc func togglePasswordVisibility() {
        guard let viewController = viewController else { return }
        viewController.passwordTextField.isSecureTextEntry.toggle()
    }

    func keyboardWillShow(notification: Notification) {
        guard let viewController = viewController,
              let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?
              .cgRectValue else { return }

        let keyboardHeight = keyboardFrame.height
        let distanceBetweenButtonAndKeyboard: CGFloat = 10
        let buttonYPosition = viewController.view.frame.height - keyboardHeight - viewController.loginButton.frame
            .height - distanceBetweenButtonAndKeyboard

        UIView.animate(withDuration: 0.3) {
            viewController.loginButton.frame.origin.y = buttonYPosition
        }
    }

    func keyboardWillHide(notification: Notification) {
        guard let viewController = viewController else { return }
        UIView.animate(withDuration: 0.3) {
            viewController.loginButton.frame.origin.y = viewController.view.frame.height - 45 - 20
        }
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

    private func showErrorPanel() {
        guard let viewController = viewController else { return }

        viewController.view.addSubview(viewController.errorView)
        viewController.makeErrorViewConstraint()
        viewController.errorView.addSubview(viewController.errorMessageLabel)
        viewController.makeErrorMessageLabel()
    }
}
