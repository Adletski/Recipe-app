// FilterTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол делегата для ячейки фильтра
protocol FilterTableViewCellDelegate: AnyObject {
    /// Вызывается при нажатии кнопки
    func onButtonPressed(state: ButtonState)
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

    let customView = SortingViewControl()
    var names = ["Calories", "Time"]

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
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.dataSource = self
        customView.delegate = self
        contentView.addSubview(customView)
    }

    /// Установка ограничений
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            customView.heightAnchor.constraint(equalToConstant: 50),
            customView.widthAnchor.constraint(equalToConstant: 230),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: -  Extension

extension FilterTableViewCell: SortingPickerDataSource {
    func sortPickerCount(_ dayPicker: SortingViewControl) -> Int {
        names.count
    }

    func sortPickerTitle(_ dayPicker: SortingViewControl, indexPath: IndexPath) -> String {
        names[indexPath.row]
    }
}

extension FilterTableViewCell: SortingViewControlDelegate {
    func onButtonPressed(state: ButtonState) {
        delegate?.onButtonPressed(state: state)
    }
}
