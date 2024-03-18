// RecipeTextCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// ячейка с текстом рецепта
final class RecipeTextCell: UITableViewCell {
    // MARK: - Constants

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

    private let textRecipeTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.backgroundColor = .clear
        textView.font = UIFont(name: Constant.verdana, size: 14)
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
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
        textRecipeTextView.text = recipe?.descriptions
    }

    // MARK: - Private Methods

    private func setupView() {
        backgroundColorView.layer.addSublayer(gradientLayer)
        contentView.addSubview(backgroundColorView)
        contentView.addSubview(textRecipeTextView)
    }

    private func setupConstraints() {
        setBackgroundColorViewConstraints()
        setTextRecipeTextViewConstraints()
    }

    private func setBackgroundColorViewConstraints() {
        backgroundColorView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        backgroundColorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
        backgroundColorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        backgroundColorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }

    private func setTextRecipeTextViewConstraints() {
        textRecipeTextView.topAnchor.constraint(equalTo: backgroundColorView.topAnchor).isActive = true
        textRecipeTextView.bottomAnchor.constraint(equalTo: backgroundColorView.bottomAnchor, constant: -10)
            .isActive = true
        textRecipeTextView.leadingAnchor.constraint(equalTo: backgroundColorView.leadingAnchor, constant: 10)
            .isActive = true
        textRecipeTextView.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor, constant: -27)
            .isActive = true
    }
}
