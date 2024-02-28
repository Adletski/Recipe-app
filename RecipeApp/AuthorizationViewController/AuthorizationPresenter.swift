// AuthorizationPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол презентера экрана авторизации
protocol AutorizationPresenterProtocol: AnyObject {
    /// Координатор флоу экрана
    var coordinator: AuthorizationCoordinator? { get set }
    /// Инициализатор с присвоением вью
    init(view: AuthorizationView)
    /// отработка для валидации почты
    func validateEmail(email: String)
    /// отработка для валидации пароля
    func validatePassword(password: String)
    /// отработка для кнопки с плашкой
    func loginButtonTapped(login: String, password: String)
    /// отработка нажатия скрытие пароля
    func createPasswordVisibilityButton(tapped: Bool)
}

/// Создание презентора для реализации mvp
final class AuthorizationPresenter: AutorizationPresenterProtocol {
    // MARK: - Public Properties

    weak var view: AuthorizationView?
    weak var coordinator: AuthorizationCoordinator?

    // MARK: - Initializers

    init(view: AuthorizationView) {
        self.view = view
    }

    // MARK: - Text Field and Keyboard Interaction Methods

    /// отработка для валидации почты
    func validateEmail(email: String) {
        if email.isEmpty {
            view?.updateValidationEmail(result: "isEmpty")
        } else if email.isEmpty || !email.contains("@mail.ru") {
            view?.updateValidationEmail(result: "noEmail")
        } else {
            view?.updateValidationEmail(result: "good")
        }
    }

    /// отработка для валидации пароля
    func validatePassword(password: String) {
        if password.isEmpty {
            view?.updateValidationPassword(result: "isEmpty")
        } else if password.isEmpty || !password.contains("qwerty12345") {
            view?.updateValidationPassword(result: "noPass")
        } else {
            view?.updateValidationPassword(result: "good")
        }
    }

    /// отработка для кнопки с плашкой
    func loginButtonTapped(login: String, password: String) {
        if login == "123@mail.ru", password == "qwerty" {
            view?.updateLoginButton(result: true)
        } else {
            view?.updateLoginButton(result: false)
        }
    }

    /// отработка нажатия скрытие пароля
    func createPasswordVisibilityButton(tapped: Bool) {
        if tapped == true {
            view?.updatePasswordVisibilityButton(result: true)
        } else {
            view?.updatePasswordVisibilityButton(result: false)
        }
    }
}
