// AuthorizationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Перечисление для валидации пароля
enum ValidationState {
    case notValid
    case `default`
}

/// Протокол для авторизации
protocol AuthorizationViewProtocol: AnyObject {
    /// метод отработки появление плашки для презентора
    func updateLoginButton(result: Bool)
    /// Обновление визуала для адреса электронной почты на основе результата валидации
    func updateValidationEmail(result: ValidationState)
    /// Обновление визуала для пароля на основе результата валидации
    func updateValidationPassword(result: ValidationState)
    /// метод отработки скрытие пароля для презентора
    func updatePasswordVisibilityButton()
}

/// Создание экрана авторизации
final class AuthorizationViewController: UIViewController, AuthorizationViewProtocol {
    enum Constant {
        static let login = "Login"
        static let verdana = "Verdana-Bold"
        static let email = "Email Address"
        static let loginColor = "loginColor"
        static let emailPlaceholder = "Enter Email Address"
        static let letterImage = "letterImage"
        static let password = "Password"
        static let passwordPlaceholder = "Enter Password"
        static let lockImage = "lockImage"
        static let buttonColor = "buttonColor"
        static let verdanaGeneral = "Verdana"
        static let warningEmail = "You entered the wrong password"
        static let warningPassword = "Incorrect format"
        static let errorViewColor = "plashkaColor"
        static let errorMessage = "Please check the accuracy of the entered credentials."
        static let eyeSlash = "eye.slash"
        static let ok = "Ok"
    }

    // MARK: - Public properties

    /// Презентер для авторизации
    var presenter: AutorizationPresenterProtocol?

    // MARK: - Visual Components

    private let labelLogin: UILabel = {
        let label = UILabel()
        label.text = Constant.login
        label.font = UIFont(name: Constant.verdana, size: 28)
        label.textColor = UIColor(named: Constant.loginColor)
        label.textAlignment = .left
        return label
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.email
        label.font = UIFont(name: Constant.verdana, size: 16)
        label.textColor = UIColor(named: Constant.loginColor)
        label.textAlignment = .left
        return label
    }()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constant.emailPlaceholder
        textField.borderStyle = .roundedRect
        textField.delegate = self
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constant.letterImage)
        imageView.contentMode = .scaleAspectFit
        textField.leftView = imageView
        textField.leftViewMode = .always
        return textField
    }()

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.password
        label.font = UIFont(name: Constant.verdana, size: 16)
        label.textColor = UIColor(named: Constant.loginColor)
        label.textAlignment = .left
        return label
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Constant.passwordPlaceholder
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.delegate = self
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constant.lockImage)
        imageView.contentMode = .scaleAspectFit
        textField.leftView = imageView
        textField.leftViewMode = .always
        return textField
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constant.login, for: .normal)
        button.backgroundColor = UIColor(named: Constant.buttonColor)
        button.titleLabel?.font = UIFont(name: Constant.verdanaGeneral, size: 16)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

    private let warningEmailLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.warningEmail
        label.textColor = .red
        label.textAlignment = .left
        label.font = UIFont(name: Constant.verdanaGeneral, size: 12)
        label.isHidden = true
        return label
    }()

    private let warningPassLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.warningPassword
        label.textColor = .red
        label.textAlignment = .left
        label.font = UIFont(name: Constant.verdanaGeneral, size: 12)
        label.isHidden = true
        return label
    }()

    private let errorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: Constant.errorViewColor)
        view.layer.cornerRadius = 12
        view.isHidden = true
        return view
    }()

    private let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.errorMessage
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    private lazy var passwordVisibilityButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: Constant.eyeSlash), for: .normal)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        setupUI()
        setupConstraints()
        setupKeyboard()
    }

    // MARK: - Private Methods

    /// добавление всех UI компонентов на экран
    private func setupUI() {
        view.addSubview(labelLogin)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(warningEmailLabel)
        view.addSubview(warningPassLabel)
        view.addSubview(errorView)
        view.addSubview(errorMessageLabel)
    }

    /// Установка всех ограничений для UI компонентов
    private func setupConstraints() {
        makeLabelLoginConstraints()
        makeEmailLabelConstraints()
        makeEmailTextFieldConstraints()
        makePasswordLabelConstraints()
        makePasswordTextFieldConstraints()
        makeLoginButtonConstraints()
        makeWarbibgLabelConstraints()
        makeWarningLabelPassConstraints()
        makeErrorViewConstraint()
        makeErrorMessageLabel()
        setupInputAccessoryView()
    }

    // MARK: - Public Methods

    /// Обновление визуала для адреса электронной почты на основе результата валидации
    func updateValidationEmail(result: ValidationState) {
        switch result {
        case .notValid:
            emailLabel.textColor = .red
            emailTextField.layer.borderColor = UIColor.red.cgColor
            emailTextField.layer.borderWidth = 1.0
            emailTextField.layer.cornerRadius = 8
            warningEmailLabel.isHidden = false
        case .default:
            emailLabel.textColor = UIColor(named: Constant.loginColor)
            emailTextField.layer.borderColor = UIColor.clear.cgColor
            emailTextField.layer.borderWidth = 0.0
            warningEmailLabel.isHidden = true
        }
    }

    /// Обновление визуала для пароля на основе результата валидации
    func updateValidationPassword(result: ValidationState) {
        switch result {
        case .notValid:
            passwordLabel.textColor = .red
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.layer.borderWidth = 1.0
            passwordTextField.layer.cornerRadius = 8
            warningPassLabel.isHidden = false
        case .default:
            passwordLabel.textColor = UIColor(named: Constant.loginColor)
            passwordTextField.layer.borderColor = UIColor.clear.cgColor
            passwordTextField.layer.borderWidth = 0.0
            warningPassLabel.isHidden = true
        }
    }

    /// метод отработки скрытие пароля для презентора
    func updatePasswordVisibilityButton() {
        passwordTextField.isSecureTextEntry.toggle()
    }

    /// метод отработки появление плашки для презентора
    func updateLoginButton(result: Bool) {
        if result == false {
            errorView.isHidden = false
            errorMessageLabel.isHidden = false
        } else {
            errorView.isHidden = false
            errorMessageLabel.isHidden = false
        }
    }

    // MARK: - Private Methods

    /// Обработчик нажатия кнопки видимости пароля
    @objc private func togglePasswordVisibility() {
        presenter?.createPasswordVisibilityButton()
    }

    /// обработчик нажатия кнопки логин
    @objc private func loginButtonTapped() {
        /// скрытие текста кнопки
        loginButton.setTitle("", for: .normal)
        startTimer()
    }

    private func startTimer() {
        /// создание и настройка индикатора загрузки
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .white
        activityIndicator.center = CGPoint(x: loginButton.bounds.midX, y: loginButton.bounds.midY)
        activityIndicator.startAnimating()
        loginButton.addSubview(activityIndicator)

        /// таймер на 3 секунды
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [weak self] _ in
            /// остановка анимации и скрытие ее
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()

            self?.presenter?.loginButtonTapped(
                login: self?.emailTextField.text ?? "",
                password: self?.passwordTextField.text ?? ""
            )
        }
    }

    @objc private func doneButtonTapped() {
        view.endEditing(true)
    }

    private func setupKeyboard() {
        setupInputAccessoryView()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    /// Обработчик появления клавиатуры
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?
            .cgRectValue else { return }

        let keyboardHeight = keyboardFrame.height
        let distanceBetweenButtonAndKeyboard: CGFloat = 10
        let buttonYPosition = view.frame.height - keyboardHeight - loginButton.frame
            .height - distanceBetweenButtonAndKeyboard

        UIView.animate(withDuration: 0.3) {
            self.loginButton.frame.origin.y = buttonYPosition
        }
    }

    /// обработчик скрытия клавиатуры
    @objc private func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.loginButton.frame.origin.y = self.view.frame.height - 65
        }
    }
}

// MARK: - AuthorizationViewController + UITextFieldDelegate

/// Расширение для управления текстовыми полями
extension AuthorizationViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            presenter?.validateEmail(email: textField.text ?? "")
        } else if textField == passwordTextField {
            presenter?.validatePassword(password: textField.text ?? "")
        }
    }
}

// MARK: - SetupConstraints

extension AuthorizationViewController {
    /// Установка ограничений для лейбла "Login"
    private func makeLabelLoginConstraints() {
        labelLogin.translatesAutoresizingMaskIntoConstraints = false
        labelLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        labelLogin.topAnchor.constraint(equalTo: view.topAnchor, constant: 86).isActive = true
        labelLogin.widthAnchor.constraint(equalToConstant: 350).isActive = true
        labelLogin.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }

    /// Установка ограничений для лейбла "Email Address"
    private func makeEmailLabelConstraints() {
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 137).isActive = true
        emailLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }

    /// Установка ограничений для текстового поля для ввода адреса электронной почты
    private func makeEmailTextFieldConstraints() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 7).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 350).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    /// Установка ограничений для лейбла "Password"
    private func makePasswordLabelConstraints() {
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 248).isActive = true
        passwordLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }

    /// Установка ограничений для текстового поля для ввода пароля
    private func makePasswordTextFieldConstraints() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 7).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 350).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let eyeButton = passwordVisibilityButton
        passwordTextField.rightView = eyeButton
        passwordTextField.rightViewMode = .always
    }

    /// Установка ограничений для кнопки Login
    private func makeLoginButtonConstraints() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        loginButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 732).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 350).isActive = true
    }

    /// установка ограничений для предупреждения почты
    private func makeWarbibgLabelConstraints() {
        warningEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        warningEmailLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8).isActive = true
        warningEmailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }

    /// установка ограничений для предупреждения пароля
    private func makeWarningLabelPassConstraints() {
        warningPassLabel.translatesAutoresizingMaskIntoConstraints = false
        warningPassLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8).isActive = true
        warningPassLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }

    /// ограничения для всплывающей плашки error
    private func makeErrorViewConstraint() {
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        errorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 674).isActive = true
        errorView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        errorView.heightAnchor.constraint(equalToConstant: 87).isActive = true
    }

    /// Ограничения для текта внутри плашки
    private func makeErrorMessageLabel() {
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.leadingAnchor.constraint(equalTo: errorView.leadingAnchor).isActive = true
        errorMessageLabel.topAnchor.constraint(equalTo: errorView.topAnchor).isActive = true
        errorMessageLabel.trailingAnchor.constraint(equalTo: errorView.trailingAnchor).isActive = true
        errorMessageLabel.bottomAnchor.constraint(equalTo: errorView.bottomAnchor).isActive = true
    }

    /// настройка панели toolBar для (Ок)
    private func setupInputAccessoryView() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        toolBar.barStyle = .default
        toolBar.sizeToFit()

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let doneButton = UIBarButtonItem(
            title: Constant.ok,
            style: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
        toolBar.items = [flexSpace, doneButton]
        toolBar.isUserInteractionEnabled = true
        emailTextField.inputAccessoryView = toolBar
        passwordTextField.inputAccessoryView = toolBar
    }

    /// настройка  градиента фона
    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.white.cgColor,
            UIColor(red: 141 / 255, green: 218 / 255, blue: 247 / 255, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
