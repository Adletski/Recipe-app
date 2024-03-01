// FilterTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для фильтра
final class FilterTableViewCell: UITableViewCell {
    // MARK: - Identifier

    static let identifier = "FilterTableViewCell"

    // MARK: - Visual components

    private let caloriesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Calories", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        return button
    }()

    private let timeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Time", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        return button
    }()

    private lazy var caloriesImageView = makeUpImageView()
    private lazy var timeImageView = makeUpImageView()

    private let caloriesStackViewH: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.backgroundColor = #colorLiteral(red: 0.9535714984, green: 0.9660330415, blue: 0.9660820365, alpha: 1)
        stackView.layer.cornerRadius = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        return stackView
    }()

    private let timeStackViewH: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.backgroundColor = #colorLiteral(red: 0.9535714984, green: 0.9660330415, blue: 0.9660820365, alpha: 1)
        stackView.layer.cornerRadius = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        return stackView
    }()

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupUI() {
        selectionStyle = .none
        caloriesStackViewH.addArrangedSubview(caloriesButton)
        caloriesStackViewH.addArrangedSubview(caloriesImageView)
        timeStackViewH.addArrangedSubview(timeButton)
        timeStackViewH.addArrangedSubview(timeImageView)
        contentView.addSubview(caloriesStackViewH)
        contentView.addSubview(timeStackViewH)
    }

    private func setupConstraints() {
        caloriesImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        caloriesImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        timeImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        timeImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true

        caloriesStackViewH.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        caloriesStackViewH.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        caloriesStackViewH.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true

        timeStackViewH.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        timeStackViewH.leadingAnchor.constraint(equalTo: caloriesStackViewH.trailingAnchor, constant: 10)
            .isActive = true
        timeStackViewH.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }

    private func makeUpImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "up")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}
