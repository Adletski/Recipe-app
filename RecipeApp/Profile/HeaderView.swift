// HeaderView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол делегата для передачи данных
protocol HeaderViewDelegate: AnyObject {
    func editButtonDidPress()
}

/// Вью хедера для таблицы
final class HeaderView: UIView {
    // MARK: - Properties

    weak var delegate: HeaderViewDelegate?

    // MARK: - Visual Components

    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Surname Name"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        return label
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "edit"), for: .normal)
        button.addTarget(self, action: #selector(editButtonPressed), for: .touchUpInside)
        return button
    }()

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private properties

    private func setupUI() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(editButton)

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            avatarImageView.heightAnchor.constraint(equalToConstant: 160),
            avatarImageView.widthAnchor.constraint(equalToConstant: 160),
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),

            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

            editButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            editButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])
    }

    @objc func editButtonPressed() {
        delegate?.editButtonDidPress()
    }
}
