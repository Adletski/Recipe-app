// FilterTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол делегата для ячейки фильтра
protocol FilterTableViewCellDelegate: AnyObject {
    /// Вызывается при нажатии кнопки калорий
    func caloriesButtonPressed(_ bool: Bool)
    /// Вызывается при нажатии кнопки времени приготовления
    func timeButtonPressed(_ bool: Bool)
}

/// Ячейка для фильтра
final class FilterTableViewCell: UITableViewCell {
    // MARK: - Identifier

    ///  идентификатор ячейки
    static let identifier = "FilterTableViewCell"
    /// Делегат ячейки фильтра
    var delegate: FilterTableViewCellDelegate?
    /// фильтруются ли калории
    var isCaloriesFiltered = false
    /// , фильтруется ли время
    var isTimeFiltered = false

    // MARK: - Visual components

    private lazy var caloriesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Calories", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(caloriesButtonPressed), for: .touchUpInside)
        return button
    }()

    private lazy var timeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Time", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(timeButtonPressed), for: .touchUpInside)
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

    /// Настройка пользовательского интерфейса
    private func setupUI() {
        selectionStyle = .none
        caloriesStackViewH.addArrangedSubview(caloriesButton)
        caloriesStackViewH.addArrangedSubview(caloriesImageView)
        timeStackViewH.addArrangedSubview(timeButton)
        timeStackViewH.addArrangedSubview(timeImageView)
        contentView.addSubview(caloriesStackViewH)
        contentView.addSubview(timeStackViewH)
    }

    /// Установка ограничений
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

    /// Создает и возвращает изображение с направлением вверх
    private func makeUpImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "up")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

    // MARK: - Action methods

    /// Обработчик нажатия на кнопку времени
    @objc private func timeButtonPressed() {
        if isTimeFiltered {
            timeStackViewH.backgroundColor = #colorLiteral(red: 0.9535714984, green: 0.9660330415, blue: 0.9660820365, alpha: 1)
            timeButton.setTitleColor(.black, for: .normal)
            timeImageView.image = UIImage(named: "up")
            isTimeFiltered = false
        } else {
            timeStackViewH.backgroundColor = #colorLiteral(red: 0.5132525563, green: 0.7558944225, blue: 0.7756446004, alpha: 1)
            timeButton.setTitleColor(.white, for: .normal)
            timeImageView.image = UIImage(named: "down")
            isTimeFiltered = true
        }
        delegate?.timeButtonPressed(isTimeFiltered)
    }

    /// Обработчик нажатия на кнопку калорий
    @objc private func caloriesButtonPressed() {
        if isCaloriesFiltered {
            caloriesStackViewH.backgroundColor = #colorLiteral(red: 0.9535714984, green: 0.9660330415, blue: 0.9660820365, alpha: 1)
            caloriesButton.setTitleColor(.black, for: .normal)
            caloriesImageView.image = UIImage(named: "up")
            isCaloriesFiltered = false
        } else {
            caloriesStackViewH.backgroundColor = #colorLiteral(red: 0.5132525563, green: 0.7558944225, blue: 0.7756446004, alpha: 1)
            caloriesButton.setTitleColor(.white, for: .normal)
            caloriesImageView.image = UIImage(named: "down")
            isCaloriesFiltered = true
        }
        delegate?.caloriesButtonPressed(isCaloriesFiltered)
    }
}
