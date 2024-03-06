// SkeletonView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SkeletonView: UIView {
    private let gradientLayer = CAGradientLayer()
    let firstColor = UIColor(red: 244.0 / 255.0, green: 246.0 / 255.0, blue: 248.0 / 255.0, alpha: 0.05).cgColor
    let secondColor = UIColor(red: 222.0 / 255.0, green: 230.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0).cgColor
    var startLocations: [NSNumber] = [-1.0, -0.5, 0.0]
    var endLocations: [NSNumber] = [1.5, 2.0, 3.0]

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradientLayer()
    }

    private func setupGradientLayer() {
        layer.cornerRadius = 12
        translatesAutoresizingMaskIntoConstraints = false
        gradientLayer.colors = [firstColor, secondColor, firstColor]
        gradientLayer.frame = bounds
        gradientLayer.locations = endLocations
        gradientLayer.startPoint = CGPoint(x: 0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1.0)
        layer.addSublayer(gradientLayer)
    }

    public func updateFrame() {
        layoutIfNeeded()
        gradientLayer.frame = bounds
    }

    public func startAnimating() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = startLocations
        animation.toValue = endLocations
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 1.5
        animationGroup.animations = [animation]
        animationGroup.repeatCount = .infinity
        gradientLayer.add(animationGroup, forKey: animation.keyPath)
    }

    public func stopAnimating() {
        gradientLayer.removeAllAnimations()
    }
}
