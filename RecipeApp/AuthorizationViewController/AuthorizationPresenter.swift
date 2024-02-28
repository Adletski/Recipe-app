// AuthorizationPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Создание презентора для реализации mvp
final class AuthorizationPresenter {
    weak var viewController: AuthorizationViewController?

    init(viewController: AuthorizationViewController) {
        self.viewController = viewController
    }

    // MARK: - Text Field and Keyboard Interaction Methods

    /// отработка для валидации почты
    func validateEmail(email: String) {
        if email.isEmpty {
            viewController?.updateValidationEmail(result: "isEmpty")
        } else if email.isEmpty || !email.contains("@mail.ru") {
            viewController?.updateValidationEmail(result: "noEmail")
        } else {
            viewController?.updateValidationEmail(result: "good")
        }
    }

    /// отработка для валидации пароля
    func validatePassword(password: String) {
        if password.isEmpty {
            viewController?.updateValidationPassword(result: "isEmpty")
        } else if password.isEmpty || !password.contains("qwerty12345") {
            viewController?.updateValidationPassword(result: "noPass")
        } else {
            viewController?.updateValidationPassword(result: "good")
        }
    }

    /// отработка для кнопки с плашкой
    func loginButtonTapped(login: String, password: String) {
        if login == "123@mail.ru", password == "qwerty" {
            viewController?.updateLoginButton(result: true)
        } else {
            viewController?.updateLoginButton(result: false)
        }
    }

    /// отработка нажатия скрытие пароля
    func createPasswordVisibilityButton(tapped: Bool) {
        if tapped == true {
            viewController?.updatePasswordVisibilityButton(result: true)
        } else {
            viewController?.updatePasswordVisibilityButton(result: false)
        }
    }
}
