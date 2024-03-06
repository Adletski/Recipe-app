// SkeletonTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка для шиммера скелетона
final class SkeletonTableViewCell: UITableViewCell {
    // MARK: - Public properties

    private lazy var skeleton1 = makeSkeletonView()
    private lazy var skeleton2 = makeSkeletonView()
    private lazy var skeleton3 = makeSkeletonView()
    private lazy var skeleton4 = makeSkeletonView()
    private lazy var skeleton5 = makeSkeletonView()

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        setupGradient()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupUI() {
        addSubview(skeleton1)
        addSubview(skeleton2)
        addSubview(skeleton3)
        addSubview(skeleton4)
        addSubview(skeleton5)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            skeleton1.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            skeleton1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            skeleton1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            skeleton1.heightAnchor.constraint(equalToConstant: 100),

            skeleton2.topAnchor.constraint(equalTo: skeleton1.bottomAnchor, constant: 20),
            skeleton2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            skeleton2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            skeleton2.heightAnchor.constraint(equalToConstant: 100),

            skeleton3.topAnchor.constraint(equalTo: skeleton2.bottomAnchor, constant: 20),
            skeleton3.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            skeleton3.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            skeleton3.heightAnchor.constraint(equalToConstant: 100),

            skeleton4.topAnchor.constraint(equalTo: skeleton3.bottomAnchor, constant: 20),
            skeleton4.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            skeleton4.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            skeleton4.heightAnchor.constraint(equalToConstant: 100),

            skeleton5.topAnchor.constraint(equalTo: skeleton4.bottomAnchor, constant: 20),
            skeleton5.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            skeleton5.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            skeleton5.heightAnchor.constraint(equalToConstant: 100),
            skeleton5.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }

    private func setupGradient() {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)

        skeleton1.layer.addSublayer(gradient)

        let animationGroup = makeAnimationGroup()
        animationGroup.beginTime = 0.0
        gradient.add(animationGroup, forKey: "backgroundColor")
        gradient.frame = skeleton1.bounds
        addSubview(skeleton1)
    }

    func makeAnimationGroup(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
        let animDuration: CFTimeInterval = 5

        let anim1 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim1.fromValue = UIColor.black.cgColor
        anim1.toValue = UIColor.gray.cgColor
        anim1.duration = animDuration
        anim1.beginTime = 0.0

        let anim2 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
        anim2.fromValue = UIColor.red.cgColor
        anim2.toValue = UIColor.black.cgColor
        anim2.duration = animDuration
        anim2.beginTime = anim1.beginTime + anim1.duration

        let group = CAAnimationGroup()
        group.animations = [anim1, anim2]
        group.repeatCount = .greatestFiniteMagnitude
        group.duration = anim2.beginTime + anim2.duration
        group.isRemovedOnCompletion = false

        if let previousGroup = previousGroup {
            group.beginTime = previousGroup.beginTime + 0.33
        }
        return group
    }

    func makeSkeletonView() -> UIView {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    func makeGradient(baseView: UIView, view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.white.cgColor,
            UIColor.clear.cgColor
        ]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.frame = view.frame

        let angle = 45 * CGFloat.pi / 180
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        view.layer.mask = gradientLayer

        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 2
        animation.fromValue = -baseView.frame.width
        animation.toValue = baseView.frame.width
        animation.repeatCount = Float.infinity

        gradientLayer.add(animation, forKey: "adlet")
    }
}
