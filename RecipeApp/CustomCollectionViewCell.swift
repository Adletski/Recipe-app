// CustomCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class CustomCollectionViewCell: UICollectionViewCell {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Adlet"
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .semibold)

        addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
