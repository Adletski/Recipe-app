// RecipeImageCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Создание ячейки с картинкой
final class RecipeImageCell: UITableViewCell {
    // MARK: - Constants

    static let identifier = Constant.identifier
    
    private enum Constant {
        static let minutesText = "min"
        static let caloriesText = "kcal"
        static let identifier = "RecipeImageCell"
        static let pot = "pot"
        static let backgroundImageColor = "backgroundImageColor"
        static let verdana = "Verdana"
        static let timerImage = "timerImage"
        static let cookingTime = "Cooking time"
        static let verdanaBold = "Verdana-Bold"
        static let simpleFish = "Simple Fish and Corn"
        static let min = "min"
    }

    // MARK: - Visual Components

    let backgroundCellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let gramsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constant.pot)
        return imageView
    }()

    private let gramsView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.backgroundColor = UIColor(named: Constant.backgroundImageColor)
        return view
    }()

    private let gramsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: Constant.verdana, size: 10)
        label.textColor = .white
        return label
    }()

    private let cookingTimeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constant.timerImage)
        return imageView
    }()

    private let cookingTimeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.backgroundColor = UIColor(named: Constant.backgroundImageColor)
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        return view
    }()

    private let cookingTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: Constant.verdana, size: 10)
        label.textColor = .white
        label.text = Constant.cookingTime
        return label
    }()

    private let cookingTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: Constant.verdana, size: 10)
        label.textColor = .white
        return label
    }()

    private let nameRecipeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: Constant.verdanaBold, size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let simpleLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.simpleFish
        label.font = UIFont(name: Constant.verdanaBold, size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers

    override var isSelected: Bool {
        didSet {
            super.isSelected = isSelected
            backgroundCellView.layer.borderColor = isSelected ? UIColor.green.cgColor : UIColor
                .green.cgColor
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Public Methods

    /// Конфигурация ячейки с рецептом
    func configure(recipe: FoodModel?) {
        guard let recipe = recipe else { return }
        nameRecipeLabel.text = recipe.name
        recipeImageView.image = UIImage(named: "\(recipe.image)")
        gramsLabel.text = "\(recipe.weight) g"
        cookingTimeLabel.text = "\(recipe.time) \(Constant.min)"
    }

    // MARK: - Private Methods

    /// Установка элементов ячейки
    private func setupCell() {
        contentView.clipsToBounds = true
        contentView.addSubview(backgroundCellView)
        contentView.addSubview(nameRecipeLabel)
        contentView.addSubview(recipeImageView)
        recipeImageView.addSubview(gramsView)
        gramsView.addSubview(gramsImageView)
        gramsView.addSubview(gramsLabel)
        recipeImageView.addSubview(cookingTimeView)
        cookingTimeView.addSubview(cookingTimeImageView)
        cookingTimeView.addSubview(cookingTimeTitleLabel)
        cookingTimeView.addSubview(cookingTimeLabel)
        contentView.addSubview(simpleLabel)
    }

    /// Установка ограничений для элементов ячейки
    private func setConstraints() {
        setBackgroundCellViewConstraints()
        setRecipeImageConstraints()
        setCookingTimeLabelConstraints()
        setCookingTimeTitleLabelConstraints()
        setCookingTimeImageViewConstraints()
        setCookingTimeViewConstraints()
        setGramsLabelConstraints()
        setGramsImageViewConstraints()
        setGramsViewConstraints()
        setRecipeImageConstraints()
        setNameRecipeLabelConstraints()
        setSimpleLabelConstraints()
    }

    private func setBackgroundCellViewConstraints() {
        backgroundCellView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        backgroundCellView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        backgroundCellView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        backgroundCellView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }

    private func setRecipeImageConstraints() {
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        recipeImageView.topAnchor.constraint(equalTo: nameRecipeLabel.bottomAnchor, constant: 20).isActive = true
        recipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        recipeImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        recipeImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

    private func setGramsViewConstraints() {
        gramsView.translatesAutoresizingMaskIntoConstraints = false
        gramsView.topAnchor.constraint(equalTo: recipeImageView.topAnchor, constant: 12).isActive = true
        gramsView.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: -10).isActive = true
        gramsView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        gramsView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setGramsImageViewConstraints() {
        gramsImageView.translatesAutoresizingMaskIntoConstraints = false
        gramsImageView.topAnchor.constraint(equalTo: gramsView.topAnchor, constant: 7).isActive = true
        gramsImageView.trailingAnchor.constraint(equalTo: gramsView.trailingAnchor, constant: -15).isActive = true
        gramsImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        gramsImageView.heightAnchor.constraint(equalToConstant: 17).isActive = true
    }

    private func setGramsLabelConstraints() {
        gramsLabel.translatesAutoresizingMaskIntoConstraints = false
        gramsLabel.topAnchor.constraint(equalTo: gramsView.topAnchor, constant: 28).isActive = true
        gramsLabel.leadingAnchor.constraint(equalTo: gramsView.leadingAnchor, constant: 6).isActive = true
        gramsLabel.widthAnchor.constraint(equalToConstant: 39).isActive = true
        gramsLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    private func setCookingTimeViewConstraints() {
        cookingTimeView.translatesAutoresizingMaskIntoConstraints = false
        cookingTimeView.bottomAnchor.constraint(equalTo: recipeImageView.bottomAnchor).isActive = true
        cookingTimeView.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor).isActive = true
        cookingTimeView.widthAnchor.constraint(equalToConstant: 124).isActive = true
        cookingTimeView.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }

    private func setCookingTimeImageViewConstraints() {
        cookingTimeImageView.translatesAutoresizingMaskIntoConstraints = false
        cookingTimeImageView.topAnchor.constraint(equalTo: cookingTimeView.topAnchor, constant: 8).isActive = true
        cookingTimeImageView.leadingAnchor.constraint(equalTo: cookingTimeView.leadingAnchor, constant: 12)
            .isActive = true
        cookingTimeImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        cookingTimeImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }

    private func setCookingTimeTitleLabelConstraints() {
        cookingTimeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cookingTimeTitleLabel.topAnchor.constraint(equalTo: cookingTimeView.topAnchor, constant: 10).isActive = true
        cookingTimeTitleLabel.trailingAnchor.constraint(equalTo: cookingTimeView.trailingAnchor, constant: -8)
            .isActive = true
        cookingTimeTitleLabel.widthAnchor.constraint(equalToConstant: 83).isActive = true
        cookingTimeTitleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    private func setCookingTimeLabelConstraints() {
        cookingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        cookingTimeLabel.topAnchor.constraint(equalTo: cookingTimeTitleLabel.bottomAnchor).isActive = true
        cookingTimeLabel.leadingAnchor.constraint(equalTo: cookingTimeImageView.trailingAnchor, constant: 15)
            .isActive = true
        cookingTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        cookingTimeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }

    private func setNameRecipeLabelConstraints() {
        nameRecipeLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        nameRecipeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        nameRecipeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    }

    private func setSimpleLabelConstraints() {
        simpleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        simpleLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 20).isActive = true
        simpleLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        simpleLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
}
