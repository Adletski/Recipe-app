// ProfileTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для таблицы профиля
final class ProfileTableViewCell: UITableViewCell {
    // MARK: - Properties

    static let identifier = "ProfileTableViewCell"

    // MARK: - Visual Components

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bonus")
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        imageView.backgroundColor = #colorLiteral(red: 0.9535714984, green: 0.9660330415, blue: 0.9660820365, alpha: 1)
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bonuses"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()

    private let chevronButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "chevron"), for: .normal)
        return button
    }()

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupUI() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(chevronButton)

        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            iconImageView.heightAnchor.constraint(equalToConstant: 48),
            iconImageView.widthAnchor.constraint(equalToConstant: 48),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),

            nameLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),

            chevronButton.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            chevronButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

    // MARK: - Public methods

    func configure(_ text: String) {
        nameLabel.text = text
    }
}
