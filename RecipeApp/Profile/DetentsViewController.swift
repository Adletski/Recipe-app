// DetentsViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран для всплывающего экрана с бонусами
final class DetentsViewController: UIViewController {
    enum Constant {
        static let xmark = "xmark"
        static let box = "box"
        static let star = "star"
        static let bonuses = "Your bonuses"
        static let bonusTotal = "100"
    }

    // MARK: - Visual Components

    private let xmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constant.xmark)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let boxImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constant.box)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constant.star)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let bonusTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constant.bonuses
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        return label
    }()

    private let bonusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constant.bonusTotal
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        return label
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        return stackView
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.layer.cornerRadius = 3
        return view
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(xmarkImageView)
        view.addSubview(bonusTitleLabel)
        view.addSubview(boxImageView)
        stackView.addArrangedSubview(starImageView)
        stackView.addArrangedSubview(bonusLabel)
        view.addSubview(stackView)
        view.addSubview(separatorView)
    }

    // MARK: - Private Methods

    private func setupConstraints() {
        makeXmarkImageViewConstraints()
        makeBonusTitleLabelConstraints()
        makeBoxImageViewConstraints()
        makeStackViewConstraints()
        makeStarImageViewConstraints()
        setupSeparatorViewConstraints()
    }

    private func makeXmarkImageViewConstraints() {
        xmarkImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        xmarkImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
    }

    private func makeBonusTitleLabelConstraints() {
        bonusTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        bonusTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    private func makeBoxImageViewConstraints() {
        boxImageView.topAnchor.constraint(equalTo: bonusTitleLabel.bottomAnchor, constant: 20).isActive = true
        boxImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        boxImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        boxImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
    }

    private func makeStackViewConstraints() {
        stackView.topAnchor.constraint(equalTo: boxImageView.bottomAnchor, constant: 35).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    private func makeStarImageViewConstraints() {
        starImageView.heightAnchor.constraint(equalToConstant: 47).isActive = true
        starImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupSeparatorViewConstraints() {
        separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        separatorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 5).isActive = true
    }
}
