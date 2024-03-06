// SkeletonTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для шиммера скелетона
final class SkeletonTableViewCell: UITableViewCell {
    // MARK: - Public properties

    lazy var customeview = SkeletonView()
    lazy var customeview2 = SkeletonView()
    lazy var customeview3 = SkeletonView()
    lazy var customeview4 = SkeletonView()
    lazy var customeview5 = SkeletonView()
    lazy var customeview6 = SkeletonView()
    lazy var customeview7 = SkeletonView()

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

    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()

        customeview.updateFrame()
        customeview2.updateFrame()
        customeview3.updateFrame()
        customeview4.updateFrame()
        customeview5.updateFrame()
        customeview6.updateFrame()
        customeview7.updateFrame()

        customeview.startAnimating()
        customeview2.startAnimating()
        customeview3.startAnimating()
        customeview4.startAnimating()
        customeview5.startAnimating()
        customeview6.startAnimating()
        customeview7.startAnimating()
    }

    // MARK: - Private methods

    private func setupUI() {
        customeview.backgroundColor = .gray
        customeview2.backgroundColor = .gray
        customeview3.backgroundColor = .gray
        customeview4.backgroundColor = .gray
        customeview5.backgroundColor = .gray
        customeview6.backgroundColor = .gray
        customeview7.backgroundColor = .gray
        addSubview(customeview)
        addSubview(customeview2)
        addSubview(customeview3)
        addSubview(customeview4)
        addSubview(customeview5)
        addSubview(customeview6)
        addSubview(customeview7)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            customeview.topAnchor.constraint(equalTo: topAnchor, constant: 42),
            customeview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            customeview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            customeview.heightAnchor.constraint(equalToConstant: 36),

            customeview2.topAnchor.constraint(equalTo: customeview.bottomAnchor, constant: 20),
            customeview2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            customeview2.heightAnchor.constraint(equalToConstant: 36),
            customeview2.widthAnchor.constraint(equalToConstant: 112),

            customeview3.topAnchor.constraint(equalTo: customeview.bottomAnchor, constant: 20),
            customeview3.leadingAnchor.constraint(equalTo: customeview2.trailingAnchor, constant: 10),
            customeview3.heightAnchor.constraint(equalToConstant: 36),
            customeview3.widthAnchor.constraint(equalToConstant: 112),

            customeview4.topAnchor.constraint(equalTo: customeview3.bottomAnchor, constant: 20),
            customeview4.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            customeview4.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            customeview4.heightAnchor.constraint(equalToConstant: 100),

            customeview5.topAnchor.constraint(equalTo: customeview4.bottomAnchor, constant: 20),
            customeview5.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            customeview5.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            customeview5.heightAnchor.constraint(equalToConstant: 100),

            customeview6.topAnchor.constraint(equalTo: customeview5.bottomAnchor, constant: 20),
            customeview6.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            customeview6.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            customeview6.heightAnchor.constraint(equalToConstant: 100),

            customeview7.topAnchor.constraint(equalTo: customeview6.bottomAnchor, constant: 20),
            customeview7.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            customeview7.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            customeview7.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
