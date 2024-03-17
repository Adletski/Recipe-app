// RecipesCustomCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол для нажатия кнопки
protocol RecipesCustomCellDelegate: AnyObject {
    /// Кнопка нажатия
    func buttonTapped(title: String)
}

/// Создание кастомной ячейки для каталога рецептов
final class RecipesCustomCell: UICollectionViewCell {
    enum Constant {
        static let identifier = "RecipesCustomCell"
        static let backgroundTextColor = "backgroungTextColor"
        static let tappcolor = "castomBlue"
    }

    // MARK: - Public properties

    let identifier = Constant.identifier
    var delegate: RecipesCustomCellDelegate?

    // MARK: - Visual Components

    private lazy var recipeButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 18
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        return button
    }()

    private let backgroundTextView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: Constant.backgroundTextColor)
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
        fatalError()
    }

    // MARK: - Public Method

    func setInfo(info: DishCategory) {
        recipeButton.setImage(UIImage(named: info.imageName), for: .normal)
        titleLabel.text = info.type.rawValue
    }

    // MARK: - Private methods

    /// Метод для создания ячейки
    private func makeCell() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 18
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 2, height: 5)
        contentView.layer.shadowRadius = 3
        contentView.layer.shadowOpacity = 0.5
    }

    /// Метод для создания вью
    private func makeView() {
        contentView.addSubview(recipeButton)
        recipeButton.addSubview(backgroundTextView)
        backgroundTextView.addSubview(titleLabel)
    }

    /// Метод для установки ограничений
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
        recipeButton.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        recipeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
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
        delegate?.buttonTapped(title: titleLabel.text ?? "")
        if recipeButton.isSelected {
            titleLabel.backgroundColor = .clear
            recipeButton.layer.borderWidth = 0
        } else {
            titleLabel.backgroundColor = UIColor(named: Constant.tappcolor)
            recipeButton.layer.borderColor = UIColor(named: Constant.tappcolor)?.cgColor
            recipeButton.layer.borderWidth = 2
        }
        recipeButton.isSelected.toggle()
    }
}
