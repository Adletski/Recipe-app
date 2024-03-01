// SearchTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для текстфилда с поиском
final class SearchTableViewCell: UITableViewCell {
    // MARK: - Identifier

    static let identifier = "SearchTableViewCell"

    // MARK: - Visual components

    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search recipes"
        textField.borderStyle = .none
        textField.backgroundColor = #colorLiteral(red: 0.9564754367, green: 0.9658924937, blue: 0.9839785695, alpha: 1)
        textField.layer.cornerRadius = 12
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addPaddingAndIcon(UIImage(named: "search"), padding: 10, isLeftView: true)
        return textField
    }()

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(searchTextField)
        searchTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        searchTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }
}
