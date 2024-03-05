// Flyweight.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// расширение для цвета
extension UIColor {
    /// словарь для кэширования цветов
    static var colorStoreMap: [String: UIColor] = [:]
    /// Создание цвета с указанными каналами RGBA
    class func rgba(
        _ red: CGFloat,
        _ green: CGFloat,
        _ blue: CGFloat,
        _ alfa: CGFloat
    ) -> UIColor {
        let key = "\(red), \(green), \(blue), \(alfa)"
        if let color = colorStoreMap[key] {
            return color
        }
        let color = UIColor(red: red, green: green, blue: blue, alpha: alfa)
        colorStoreMap[key] = color
        return color
    }
}

/// Расширение для шрифтов
extension UIFont {
    /// Создание жирного шрифта Verdana
    class func verdanaBold(ofSize fontSize: CGFloat) -> UIFont {
        UIFont(name: "Verdana-Bold", size: fontSize) ?? UIFont()
    }

    /// Создание шрифта Verdana
    class func verdana(ofSize fontSize: CGFloat) -> UIFont {
        UIFont(name: "Verdana", size: fontSize) ?? UIFont()
    }
}
