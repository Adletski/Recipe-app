// AuthorizationViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Создание экрана авторизации
class AuthorizationViewController: UIViewController {
    // MARK: - Properties

    var presenter: AuthorizationPresenter?

    // MARK: - Visual Components

    /// Лейбл для текста "Login"
    let labelLogin: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = UIFont(name: "Verdana-Bold", size: 28)
        label.textColor = UIColor(named: "loginColor")
        label.textAlignment = .left
        return label
    }()

    /// Лейбл для текста "Email Address"
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email Address"
        label.font = UIFont(name: "Verdana-Bold", size: 16)
        label.textColor = UIColor(named: "loginColor")
        label.textAlignment = .left
        return label
    }()

    /// Текстовое поле для ввода адреса электронной почты
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Email Address"
        textField.borderStyle = .roundedRect
        textField.delegate = self
        return textField
    }()

    /// Лейбл для текста "Password"
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont(name: "Verdana-Bold", size: 16)
        label.textColor = UIColor(named: "loginColor")
        label.textAlignment = .left
        return label
    }()

    /// Текстовое поле для ввода пароля
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()

    /// Кнопка для входа
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor(named: "buttonColor")
        button.titleLabel?.font = UIFont(name: "Verdana", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

    /// предупрежденеи для почты
    let warningEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "You entered the wrong password"
        label.textColor = .red
        label.textAlignment = .left
        label.font = UIFont(name: "Verdana", size: 12)
        label.isHidden = true
        return label
    }()

    /// предупреждение для пароля
    let warningPassLabel: UILabel = {
        let label = UILabel()
        label.text = "Incorrect format"
        label.textColor = .red
        label.textAlignment = .left
        label.font = UIFont(name: "Verdana", size: 12)
        label.isHidden = true
        return label
    }()

    /// дополнительная вью (плашка)
    let errorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "plashkaColor")
        view.layer.cornerRadius = 12
        view.isHidden = true
        return view
    }()

    /// текст для плашки
    let errorMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Please check the accuracy of the entered credentials."
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
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

    /// Создание кнопки видимости пароля
    func createPasswordVisibilityButton() -> UIButton {
        let eyeButton = UIButton(type: .custom)
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        eyeButton.tintColor = .gray
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return eyeButton
    }

    func setupUI() {
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

    func setupConstraints() {
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

    func updateValidationEmail(result: String) {
        if result == "isEmpty" {
            emailTextField.layer.borderColor = UIColor.clear.cgColor
            emailTextField.layer.borderWidth = 0.0
            emailLabel.textColor = UIColor(named: "loginColor")
            warningEmailLabel.isHidden = true
        } else if result == "noEmail" {
            emailLabel.textColor = .red
            emailTextField.layer.borderColor = UIColor.red.cgColor
            emailTextField.layer.borderWidth = 1.0
            emailTextField.layer.cornerRadius = 8
            warningEmailLabel.isHidden = false
        } else {
            emailLabel.textColor = UIColor(named: "loginColor")
            emailTextField.layer.borderColor = UIColor.clear.cgColor
            emailTextField.layer.borderWidth = 0.0
            warningEmailLabel.isHidden = true
        }
    }

    /// Обработчик нажатия кнопки видимости пароля
    @objc func togglePasswordVisibility() {
//        presenter?.togglePasswordVisibility()
    }

    /// обработчик нажатия кнопки логин
    @objc func loginButtonTapped() {
        presenter?.loginButtonTapped(login: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }

    func chekIt(_ chek: Bool) {
        if chek == true {
            print("ypa")
            loginButton.setTitleColor(.green, for: .normal)
        } else {
            loginButton.setTitleColor(.red, for: .normal)
        }
    }
}

// MARK: - ViewController: UITextFieldDelegate

/// Расширение для управления текстовыми полями
extension AuthorizationViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text)
        if textField == emailTextField {
            presenter?.validateEmail(email: textField.text ?? "")
        } else if textField == passwordTextField {
            presenter?.validatePassword(password: textField.text ?? "")
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {}

    @objc private func doneButtonTapped() {
        view.endEditing(true)
    }
}

// keyboard
extension AuthorizationViewController {
    func setupKeyboard() {
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
    @objc func keyboardWillShow(notification: Notification) {
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
    @objc func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.loginButton.frame.origin.y = self.view.frame.height - 45 - 20
        }
    }
}

extension AuthorizationViewController {
    /// Установка ограничений для лейбла "Login"
    func makeLabelLoginConstraints() {
        labelLogin.translatesAutoresizingMaskIntoConstraints = false
        labelLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        labelLogin.topAnchor.constraint(equalTo: view.topAnchor, constant: 86).isActive = true
        labelLogin.widthAnchor.constraint(equalToConstant: 350).isActive = true
        labelLogin.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }

    /// Установка ограничений для лейбла "Email Address"
    func makeEmailLabelConstraints() {
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 137).isActive = true
        emailLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }

    /// Установка ограничений для текстового поля для ввода адреса электронной почты
    func makeEmailTextFieldConstraints() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 7).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 350).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    /// Установка ограничений для лейбла "Password"
    func makePasswordLabelConstraints() {
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 248).isActive = true
        passwordLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }

    /// Установка ограничений для текстового поля для ввода пароля
    func makePasswordTextFieldConstraints() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 7).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 350).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let eyeButton = createPasswordVisibilityButton()
        passwordTextField.rightView = eyeButton
        passwordTextField.rightViewMode = .always
    }

    /// Установка ограничений для кнопки Login
    func makeLoginButtonConstraints() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        loginButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 732).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 350).isActive = true
    }

    /// установка ограничений для предупреждения почты
    func makeWarbibgLabelConstraints() {
        warningEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        warningEmailLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8).isActive = true
        warningEmailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }

    /// установка ограничений для предупреждения пароля
    func makeWarningLabelPassConstraints() {
        warningPassLabel.translatesAutoresizingMaskIntoConstraints = false
        warningPassLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8).isActive = true
        warningPassLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }

    /// ограничения для всплывающей плашки error
    func makeErrorViewConstraint() {
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        errorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 674).isActive = true
        errorView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        errorView.heightAnchor.constraint(equalToConstant: 87).isActive = true
    }

    /// Ограничения для текта внутри плашки
    func makeErrorMessageLabel() {
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.leadingAnchor.constraint(equalTo: errorView.leadingAnchor).isActive = true
        errorMessageLabel.topAnchor.constraint(equalTo: errorView.topAnchor).isActive = true
        errorMessageLabel.trailingAnchor.constraint(equalTo: errorView.trailingAnchor).isActive = true
        errorMessageLabel.bottomAnchor.constraint(equalTo: errorView.bottomAnchor).isActive = true
    }

    /// Установка вспомогательной понели для ввода текста (Ок)
    func setupInputAccessoryView() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        toolBar.barStyle = .default
        toolBar.sizeToFit()

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let doneButton = UIBarButtonItem(
            title: "Ok",
            style: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
        toolBar.items = [flexSpace, doneButton]
        toolBar.isUserInteractionEnabled = true
        emailTextField.inputAccessoryView = toolBar
        passwordTextField.inputAccessoryView = toolBar
    }

    func setupGradientBackground() {
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
