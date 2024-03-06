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
}

/// Создание презентора для реализации mvp
final class AuthorizationPresenter: AutorizationPresenterProtocol {
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
        if email.isEmpty || !email.contains("@mail.ru") {
            view?.updateValidationEmail(result: .notValid)
        } else {
            view?.updateValidationEmail(result: .default)
        }
    }

    /// отработка для валидации пароля
    func validatePassword(password: String) {
        if password.isEmpty || !password.contains("qwerty") {
            view?.updateValidationPassword(result: .notValid)
        } else {
            view?.updateValidationPassword(result: .default)
        }
    }

    /// отработка для кнопки с плашкой
    func loginButtonTapped(login: String, password: String) {
        if login == "123@mail.ru", password == "qwerty" {
            coordinator?.finish()
        } else {
            view?.updateLoginButton(result: false)
        }
    }

    /// отработка нажатия скрытие пароля
    func createPasswordVisibilityButton() {
        view?.updatePasswordVisibilityButton()
    }
}
