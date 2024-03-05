// TermsPrivacyPolicyController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// создание вью с политикой конфеденциальности
class TermsPrivacyPolicyView: UIView {
    // MARK: - Constants

    private let textViewTopAnchorConstant: CGFloat = 25

    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Terms of Use"
        label.font = UIFont(name: "Verdana-Bold", size: 20)
        return label
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.cornerRadius = 3
        return view
    }()

    private let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.text = """
        Welcome to our recipe app! We're thrilled to have you on board.
        To ensure a delightful experience for everyone, please take a moment to familiarize yourself with our rules:
        User Accounts:
        • Maintain one account per user.
        • Safeguard your login credentials; don't share them with others.
        Content Usage:
        • Recipes and content are for personal use only.
        • Do not redistribute or republish recipes without proper attribution.
        Respect Copyright:
        • Honor the copyright of recipe authors and contributors.
        • Credit the original source when adapting or modifying a recipe.
        Community Guidelines:
        • Show respect in community features.
        • Avoid offensive language or content that violates community standards.
        Feedback and Reviews:
        • Share constructive feedback and reviews.
        • Do not submit false or misleading information.
        Data Privacy:
        • Review and understand our privacy policy regarding data collection and usage.
        Compliance with Laws:
        • Use the app in compliance with all applicable laws and regulations.
        Updates to Terms:
        • Stay informed about updates; we'll notify you of any changes.
        By using our recipe app, you agree to adhere to these rules.
        Thank you for being a part of our culinary community! Enjoy exploring and cooking up a storm!
        """
        textView.font = UIFont(name: "Verdana", size: 14)
        return textView
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    /// Настройка интерфейса
    private func setupUI() {
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(separatorView)
        addSubview(textView)
    }

    /// Настройка констрейнтов
    private func setupConstraints() {
        setupCloseButtonConstraints()
        setupTitleLabelConstraints()
        setupSeparatorViewConstraints()
        setupTextViewConstraints()
    }

    private func setupCloseButtonConstraints() {
        closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 14).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
    }

    private func setupTitleLabelConstraints() {
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
    }

    private func setupSeparatorViewConstraints() {
        separatorView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 14).isActive = true
        separatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 5).isActive = true
    }

    private func setupTextViewConstraints() {
        textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
