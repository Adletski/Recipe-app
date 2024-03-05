// EmptyView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Класс  представляющий пустое представление для отображения, когда нет данных
final class EmptyView: UIView {
    // MARK: - Visual Components

    private let emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "emptyView")
        return imageView
    }()

    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "There's nothing here yet"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Add interesting recipes to make ordering products convenient"
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 2
        label.textColor = .systemGray3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let stackViewV: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.alignment = .center
        return stackView
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Private Methods

    /// Настраивает пользовательский интерфейс
    private func setupUI() {
        stackViewV.addArrangedSubview(emptyImageView)
        stackViewV.addArrangedSubview(emptyLabel)
        stackViewV.addArrangedSubview(descriptionLabel)
        addSubview(stackViewV)
        NSLayoutConstraint.activate([
            emptyImageView.widthAnchor.constraint(equalToConstant: 50),
            emptyImageView.heightAnchor.constraint(equalToConstant: 50),
            stackViewV.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackViewV.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackViewV.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
