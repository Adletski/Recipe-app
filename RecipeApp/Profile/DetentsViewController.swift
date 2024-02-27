// DetentsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class DetentsViewController: UIViewController {
    private let xmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "xmark")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let boxImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "box")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let bonusTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Your bonuses"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()

    private let bonusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "100"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(xmarkImageView)
        view.addSubview(bonusTitleLabel)
        view.addSubview(boxImageView)
        stackView.addArrangedSubview(starImageView)
        stackView.addArrangedSubview(bonusLabel)
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            xmarkImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            xmarkImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),

            bonusTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            bonusTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            boxImageView.topAnchor.constraint(equalTo: bonusTitleLabel.bottomAnchor, constant: 10),
            boxImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            boxImageView.widthAnchor.constraint(equalToConstant: 150),
            boxImageView.heightAnchor.constraint(equalToConstant: 140),

            stackView.topAnchor.constraint(equalTo: boxImageView.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            starImageView.heightAnchor.constraint(equalToConstant: 27),
            starImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
