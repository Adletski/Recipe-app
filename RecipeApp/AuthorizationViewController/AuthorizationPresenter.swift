// AuthorizationPresenter.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - Types

/// Протокол презентера экрана авторизации
protocol AutorizationPresenterProtocol: AnyObject {
    /// Координатор флоу экрана
    var coordinator: AuthorizationCoordinator? { get set }
    /// Инициализатор с присвоением вью
    init(view: AuthorizationViewProtocol, coordinator: AuthorizationCoordinator)
    /// отработка для валидации почты
    func validateEmail(email: String)
    /// отработка для валидации пароля
    func validatePassword(password: String)
    /// отработка для кнопки с плашкой
    func loginButtonTapped(login: String, password: String)
    /// отработка нажатия скрытие пароля
    func createPasswordVisibilityButton()
    func saveUserInfo(login: String, password: String)
}

/// Создание презентора для реализации mvp
final class AuthorizationPresenter: AutorizationPresenterProtocol {
    enum Constant {
        static let mailru = "@mail.ru"
        static let qwerty = "qwerty"
        static let simpleMail = "123@mail.ru"
    }

    // MARK: - Public Properties

    weak var view: AuthorizationViewProtocol?
    weak var coordinator: AuthorizationCoordinator?

    // MARK: - Initializers

    init(view: AuthorizationViewProtocol, coordinator: AuthorizationCoordinator) {
        self.view = view
        self.coordinator = coordinator
    }

    // MARK: - Text Field and Keyboard Interaction Methods

    /// отработка для валидации почты
    func validateEmail(email: String) {
        if email.isEmpty || !email.contains(Constant.mailru) {
            view?.updateValidationEmail(result: .notValid)
        } else {
            view?.updateValidationEmail(result: .default)
        }
    }

    /// отработка для валидации пароля
    func validatePassword(password: String) {
        if password.isEmpty || !password.contains(Constant.qwerty) {
            view?.updateValidationPassword(result: .notValid)
        } else {
            view?.updateValidationPassword(result: .default)
        }
    }

    /// отработка для кнопки с плашкой
    func loginButtonTapped(login: String, password: String) {
        let usLogin = UserDefaults.standard.object(forKey: "login") as? String
        let usPassword = UserDefaults.standard.object(forKey: "password") as? String
        if login == usLogin, password == usPassword {
            coordinator?.finish()
        } else {
            view?.updateLoginButton(result: false)
        }
    }

    /// отработка нажатия скрытие пароля
    func createPasswordVisibilityButton() {
        view?.updatePasswordVisibilityButton()
    }

    func saveUserInfo(login: String, password: String) {
//        UserSettings.userInfo = UserInfo(name: "", surname: "", login: login, password: password)
    }
}
