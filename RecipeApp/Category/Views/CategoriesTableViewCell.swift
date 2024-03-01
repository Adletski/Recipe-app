// CategoriesTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с продуктами для таблицы
final class CategoriesTableViewCell: UITableViewCell {
    // MARK: - Identifier

    static let identifier = "CategoriesTableViewCell"

    // MARK: - Visual components

    private let wrapView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9535714984, green: 0.9660330415, blue: 0.9660820365, alpha: 1)
        view.layer.cornerRadius = 12
        return view
    }()

    private let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "food1")
        return imageView
    }()

    private let foodLabel: UILabel = {
        let label = UILabel()
        label.text = "Simple Fish and Corn"
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let clockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "clock")
        return imageView
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "60 min"
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let cookingTimeStackViewH: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let pizzaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "pizza")
        return imageView
    }()

    private let caloriesLabel: UILabel = {
        let label = UILabel()
        label.text = "274 kkal"
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let caloriesStackViewH: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "cellChevron")
        return imageView
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
        contentView.addSubview(wrapView)
        contentView.addSubview(foodImageView)
        contentView.addSubview(foodLabel)
        contentView.addSubview(chevronImageView)
        cookingTimeStackViewH.addArrangedSubview(clockImageView)
        cookingTimeStackViewH.addArrangedSubview(timeLabel)
        caloriesStackViewH.addArrangedSubview(pizzaImageView)
        caloriesStackViewH.addArrangedSubview(caloriesLabel)
        contentView.addSubview(cookingTimeStackViewH)
        contentView.addSubview(caloriesStackViewH)
    }

    private func setupConstraints() {
        clockImageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        clockImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true

        pizzaImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        pizzaImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true

        chevronImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        chevronImageView.widthAnchor.constraint(equalToConstant: 13).isActive = true

        wrapView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6).isActive = true
        wrapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        wrapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        wrapView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        wrapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6).isActive = true

        foodImageView.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: 10).isActive = true
        foodImageView.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: 10).isActive = true
        foodImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        foodImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        foodImageView.bottomAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: -10).isActive = true

        chevronImageView.centerYAnchor.constraint(equalTo: wrapView.centerYAnchor).isActive = true
        chevronImageView.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: -10).isActive = true

        foodLabel.topAnchor.constraint(equalTo: foodImageView.topAnchor, constant: 10).isActive = true
        foodLabel.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 20).isActive = true
        foodLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -5).isActive = true

        cookingTimeStackViewH.topAnchor.constraint(equalTo: foodLabel.bottomAnchor, constant: 20).isActive = true
        cookingTimeStackViewH.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 20)
            .isActive = true
        cookingTimeStackViewH.widthAnchor.constraint(equalToConstant: 100).isActive = true

        caloriesStackViewH.topAnchor.constraint(equalTo: foodLabel.bottomAnchor, constant: 20).isActive = true
        caloriesStackViewH.leadingAnchor.constraint(equalTo: cookingTimeStackViewH.trailingAnchor, constant: 10)
            .isActive = true
        caloriesStackViewH.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: 10)
            .isActive = true
    }

    // MARK: - Pbulic methods

    func configure(model: FoodModel) {
        foodImageView.image = UIImage(named: model.image)
        foodLabel.text = model.name
        timeLabel.text = model.time
        caloriesLabel.text = model.kkal
    }
}
