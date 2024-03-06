// Extension + UIView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIView {
    /// Добавление  эффекта мерцания
    func startShimmeringAnimation() {
        // MARK: - Constants

        /// Базовые параметры
        let lightColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5).cgColor
        let blackColor = UIColor.black.cgColor
        let animationSpeed = 1.0
        let gradientLayer = makeGradientLayer()
        gradientLayer.colors = [blackColor, lightColor, blackColor]
        layer.mask = gradientLayer
        addGrayShimmerLayer()
        CATransaction.begin()
        let animation = makeAnimation(animationSpeed: animationSpeed)
        gradientLayer.add(animation, forKey: "shimmerAnimation")
        CATransaction.commit()
    }

    // MARK: - Private Methods

    /// Удаление эффекта мерцания из представления
    private func stopShimmeringAnimation() {
        layer.mask = nil
        layer.sublayers?.first?.removeFromSuperlayer()
    }

    /// Создание градиентного слоя для эффекта мерцания
    private func makeGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(
            x: -bounds.size.width,
            y: -bounds.size.height,
            width: 3 * bounds.size.width,
            height: 3 * bounds.size.height
        )
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.locations = [0.35, 0.50, 0.65]
        return gradientLayer
    }

    /// Добавление серого слоя для мерцающего эффекта
    private func addGrayShimmerLayer() {
        let grayShimmerLayer = CALayer()
        grayShimmerLayer.backgroundColor = UIColor.systemGray4.cgColor
        grayShimmerLayer.frame = bounds
        grayShimmerLayer.cornerRadius = grayShimmerLayer.frame.height > 60 ? 12 : grayShimmerLayer.frame.height / 5
        grayShimmerLayer.masksToBounds = true
        layer.addSublayer(grayShimmerLayer)
    }

    /// Создание анимации с заданными параметрами
    /// - Parameter animationSpeed: временной интервал для повторения анимации
    private func makeAnimation(animationSpeed: CGFloat) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = CFTimeInterval(animationSpeed)
        animation.repeatCount = .infinity
        return animation
    }
}
