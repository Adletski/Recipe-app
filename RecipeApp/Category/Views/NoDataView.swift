// NoDataView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class NoDataView: UIView {
    private let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "search")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let notFoundLabel: UILabel = {
        let label = UILabel()
        label.text = "Not Found"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()

    private let queryLabel: UILabel = {
        let label = UILabel()
        label.text = "Try entering your query differently"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchImageView)
        addSubview(notFoundLabel)
        addSubview(queryLabel)

        NSLayoutConstraint.activate([
            searchImageView.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            searchImageView.centerXAnchor.constraint(equalTo: centerXAnchor),

            notFoundLabel.topAnchor.constraint(equalTo: searchImageView.bottomAnchor, constant: 10),
            notFoundLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            queryLabel.topAnchor.constraint(equalTo: notFoundLabel.bottomAnchor, constant: 10),
            queryLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
