// RecipeTextCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// ячейка с текстом рецепта
final class RecipeTextCell: UITableViewCell {
     //MARK: - Constants

    enum Constant {
        static let customBlue = "castomBlue"
        static let identifier = "RecipeTextCell"
        static let verdana = "Verdana"
        static let backColor = "backColor"
    }

    static let identifier = Constant.identifier

    // MARK: - Visual Components

    private let backgroundColorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: Constant.customBlue)
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let textRecipeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Constant.verdana, size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(named: Constant.backColor)?.cgColor ?? "",
            UIColor.white.cgColor,
        ]
        return gradientLayer
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = backgroundColorView.bounds
    }

    // MARK: - Public Methods

    func configure(recipe: FoodModel?) {
        textRecipeLabel.text = recipe?.descriptions
    }

    // MARK: - Private Methods

    private func setupView() {
        backgroundColorView.layer.addSublayer(gradientLayer)
        contentView.addSubview(backgroundColorView)
        contentView.addSubview(textRecipeLabel)
    }

    private func setupConstraints() {
        setBackgroundColorViewConstraints()
        setTextRecipeLabelConstraints()
    }

    private func setBackgroundColorViewConstraints() {
        backgroundColorView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        backgroundColorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
        backgroundColorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        backgroundColorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }

    private func setTextRecipeLabelConstraints() {
        textRecipeLabel.topAnchor.constraint(equalTo: backgroundColorView.topAnchor).isActive = true
        textRecipeLabel.bottomAnchor.constraint(equalTo: backgroundColorView.bottomAnchor, constant: -10)
            .isActive = true
        textRecipeLabel.leadingAnchor.constraint(equalTo: backgroundColorView.leadingAnchor, constant: 10)
            .isActive = true
        textRecipeLabel.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor, constant: -27)
            .isActive = true
    }
}
