// HeaderView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол делегата для передачи данных
protocol HeaderViewDelegate: AnyObject {
    /// Обработка нажатия кнопки на изменение
    func editButtonDidPress()
}

/// Вью хедера для таблицы
final class HeaderView: UIView {
    enum Constant {
        static let avatarImageView = "avatar"
        static let fullname = "Surname Name"
        static let edit = "edit"
    }

    // MARK: - Properties

    weak var delegate: HeaderViewDelegate?

    // MARK: - Visual Components

    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constant.avatarImageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constant.fullname
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        return label
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: Constant.edit), for: .normal)
        button.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        return button
    }()

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Private properties

    private func setupUI() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(editButton)
    }

    private func setupConstraints() {
        makeAvatarImageViewConstraints()
        makeNameLabelConstraints()
        makeEditButtonConstraints()
    }

    private func makeAvatarImageViewConstraints() {
        avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    private func makeNameLabelConstraints() {
        nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }

    private func makeEditButtonConstraints() {
        editButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10).isActive = true
        editButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
    }

    // MARK: - IBAction
    /// Обработчик нажатия кнопки редактирования профиля
    @objc private func editButtonPressed() {
        delegate?.editButtonDidPress()
    }
}
