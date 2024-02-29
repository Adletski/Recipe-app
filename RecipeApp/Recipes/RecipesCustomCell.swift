// RecipesCustomCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Создание кастомной ячейки для каталога рецептов
final class RecipesCustomCell: UICollectionViewCell {
    // MARK: - Public properties

    let identifier = "RecipesCustomCell"

    // MARK: - Visual Components

    private let recipeButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 18
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        return button
    }()

    private let backgroundTextView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "backgroungTextColor")
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeCell()
        makeView()
        setupConstraint()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Method

    func setInfo(info: DishCategory) {
        recipeButton.setImage(UIImage(named: info.imageName), for: .normal)
        titleLabel.text = info.type.rawValue
    }

    // MARK: - Private methods

    /// метод для создания ячейки
    private func makeCell() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 18
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 2, height: 5)
        contentView.layer.shadowRadius = 3
        contentView.layer.shadowOpacity = 0.5
    }

    ///  метод для создания вью
    private func makeView() {
        contentView.addSubview(recipeButton)
        recipeButton.addSubview(backgroundTextView)
        backgroundTextView.addSubview(titleLabel)
    }

    ///  метод для установки ограничений
    private func setupConstraint() {
        makeRecipeButtonConstraints()
        makeBackgroundTextViewConstraints()
        makeTitleLabelConstraints()
    }

    /// Установка ограничений для кнопки
    private func makeRecipeButtonConstraints() {
        recipeButton.translatesAutoresizingMaskIntoConstraints = false
        recipeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        recipeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        recipeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        recipeButton.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    }

    /// Установка ограничений для фона текстовой области
    private func makeBackgroundTextViewConstraints() {
        backgroundTextView.translatesAutoresizingMaskIntoConstraints = false
        backgroundTextView.leadingAnchor.constraint(equalTo: recipeButton.leadingAnchor).isActive = true
        backgroundTextView.trailingAnchor.constraint(equalTo: recipeButton.trailingAnchor).isActive = true
        backgroundTextView.bottomAnchor.constraint(equalTo: recipeButton.bottomAnchor).isActive = true
        backgroundTextView.topAnchor.constraint(
            equalTo: recipeButton.bottomAnchor,
            constant: -contentView.frame.size.width / 5
        ).isActive = true
    }

    /// Установка ограничений для заголовка ячейки
    private func makeTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: backgroundTextView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: backgroundTextView.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: backgroundTextView.bottomAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
    }

    // MARK: - IBAction

    /// Обработка нажатия на кнопку ячейки
    @objc func tappedButton() {
        if recipeButton.isSelected {
            titleLabel.backgroundColor = .clear
            recipeButton.layer.borderWidth = 0
        } else {
            titleLabel.backgroundColor = UIColor(named: "tappColor")
            recipeButton.layer.borderColor = UIColor(red: 114 / 255, green: 186 / 255, blue: 191 / 255, alpha: 1)
                .cgColor
            recipeButton.layer.borderWidth = 2
        }
        recipeButton.isSelected.toggle()
    }
}
