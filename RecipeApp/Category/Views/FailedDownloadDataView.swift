// FailedDownloadDataView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol FailedDownloadDataViewDelegate {
    func reloadButtonPressed()
}

final class FailedDownloadDataView: UIView {
    var delegate: FailedDownloadDataViewDelegate?

    private let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lightning")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let notFoundLabel: UILabel = {
        let label = UILabel()
        label.text = "Failed to load data"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()

    private let reloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reload", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.gray, for: .normal)
        button.setImage(UIImage(named: "reload"), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9564754367, green: 0.9658924937, blue: 0.9839785695, alpha: 1)
        button.layer.cornerRadius = 12
        button.setInsets(forContentPadding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10), imageTitlePadding: 10)
        button.addTarget(self, action: #selector(reloadButtonPressed), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(searchImageView)
        addSubview(notFoundLabel)
        addSubview(reloadButton)

        NSLayoutConstraint.activate([
            searchImageView.topAnchor.constraint(equalTo: topAnchor, constant: 200),
            searchImageView.centerXAnchor.constraint(equalTo: centerXAnchor),

            notFoundLabel.topAnchor.constraint(equalTo: searchImageView.bottomAnchor, constant: 10),
            notFoundLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            reloadButton.topAnchor.constraint(equalTo: notFoundLabel.bottomAnchor, constant: 10),
            reloadButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            reloadButton.heightAnchor.constraint(equalToConstant: 32),
            reloadButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func reloadButtonPressed() {
        delegate?.reloadButtonPressed()
    }
}

extension UIButton {
    func setInsets(
        forContentPadding contentPadding: UIEdgeInsets,
        imageTitlePadding: CGFloat
    ) {
        contentEdgeInsets = UIEdgeInsets(
            top: contentPadding.top,
            left: contentPadding.left,
            bottom: contentPadding.bottom,
            right: contentPadding.right + imageTitlePadding
        )
        titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: imageTitlePadding,
            bottom: 0,
            right: -imageTitlePadding
        )
    }
}
